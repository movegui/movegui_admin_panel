import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
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

Future<void> createSuperUser(BuildContext context) async {
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

    await createUserInDatabase(
      email: email,
      uid: firebaseUser.uid,
      firebaseUser: firebaseUser,
      userService: userService,
      context: context,
      role: UserRole.SuperAdmin.name,
      phone: null
    );
  } on FirebaseAuthException {

    /*
    handleExistingFirebaseSuperAdmin(
      email: email,
      password: password,
      userService: userService,
    );
    */
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

Future<void> createUserInDatabase({
  required String email,
  required String uid,
  required User firebaseUser,
  required UserService userService,
  required BuildContext context,
  required String role,
  required String? phone
}) async {
  UserModel createdUser ;
  if(phone != null && phone.isNotEmpty){
    createdUser = await userService.initializeUserWithEmailAndUIDAndPhone(
    email,
    uid,
    phone
  );
  }else{
    createdUser = await userService.initializeUserWithEmailAndUID(
    email,
    uid
  );
  }
  final user = await userService.addModel(createdUser);
  createdUser = user;
  await userService.setUserRole(context, createdUser.id, role);
  createdUser.role = UserRole.values.firstWhere((e) => e.name == role , orElse: () => UserRole.Guest) ;
  await userService.update(createdUser);
  await FirebaseAuth.instance.signOut();
}

Future<Map<String, dynamic>> loadConfig() async {
  final jsonString = await rootBundle.loadString('assets/config.json');
  return json.decode(jsonString);
}

Future<void> createSupportUser(BuildContext context) async {
  final userService = getIt<UserService>();

  final config = await loadConfig();
  final email = config['support.email'] as String?;
  final password = config['support.pw'] as String?;
  final phone = config['support.phone'] as String?;

  if (email == null || email.isEmpty || password == null || password.isEmpty || phone == null || phone.isEmpty || !MyValidators.isValidGuineaPhone(phone))  {
    return;
  }

  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final firebaseUser = credential.user;
    if (firebaseUser == null) {
      throw Exception(
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_register_title,
          AppLocalizations.of(context)!.error_register_with_email_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        ),
      );
    }

    await createUserInDatabase(
      email: email,
      uid: firebaseUser.uid,
      firebaseUser: firebaseUser,
      userService: userService,
      context: context,
      role: UserRole.Support.name,
      phone: phone
    );
  } on FirebaseAuthException {
    handleExistingFirebaseSuperAdmin(
      email: email,
      password: password,
      userService: userService,
    );
  }
}
