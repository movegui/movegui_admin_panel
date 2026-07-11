import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';

// firebase emulators:start --export-on-exit=./emulator-data
// firebase emulators:start --import=./emulator-data

/*
netstat -ano | findstr :9399
netstat -ano | findstr :8080
netstat -ano | findstr :9000
netstat -ano | findstr :5432
------------------------------------------------
taskkill /PID 12345 /F
*/

Future<void> createSuperUser() async {
  final userService = getIt<UserService>();

  final config = await loadConfig();
  final email = config['super.email'] as String?;
  final password = config['super.pw'] as String?;

  if (email == null || email.isEmpty || password == null || password.isEmpty) {
    return;
  }

  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final firebaseUser = credential.user;
    if (firebaseUser == null) {
      throw Exception(
        'Firebase user Creation Exception: User is null after creation',
      );
    }

    await createSuperAdminInDatabase(
      email: email,
      uid: firebaseUser.uid,
      firebaseUser: firebaseUser,
      userService: userService,
    );
  } on FirebaseAuthException {
    handleExistingFirebaseSuperAdmin(
      email: email,
      password: password,
      userService: userService,
    );
  }
}

Future<void> handleExistingFirebaseSuperAdmin({
  required String email,
  required String password,
  required UserService userService,
}) async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      return;
    }

    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception('Firebase user is null after sign in');
    }

    print('✅ Existing Firebase user added as SuperAdmin in database');
  } on FirebaseAuthException catch (e) {
    throw Exception(
      e.message ??
          'FirebaseAuthException: Unknown error occurred while creating super admin',
    );
  }
}

Future<void> createSuperAdminInDatabase({
  required String email,
  required String uid,
  required User firebaseUser,
  required UserService userService,
}) async {
  UserModel superUser = await userService.initializeUserWithEmailAndUID(
    email,
    uid,
  );
  final user = await userService.addModel(superUser);
  superUser = user;
  await userService.setSuperAdminRole(superUser.id);
  superUser.role = UserRole.SuperAdmin.name;
  await userService.update(superUser);
  await FirebaseAuth.instance.signOut();
}

Future<Map<String, dynamic>> loadConfig() async {
  final jsonString = await rootBundle.loadString('assets/config.json');
  return json.decode(jsonString);
}
