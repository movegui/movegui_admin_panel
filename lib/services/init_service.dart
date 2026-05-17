import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';

Future<void> createSuperUser() async {
  UserCredential? credential;
  final userService = getIt<UserService>();
  final config = await loadConfig();
  final email = config['super.email'];
  final password = config['super.pw'];
  if (password != null && email != null) {
    final superAdmins = await userService.getSuperAdmins();
    if (superAdmins.isEmpty) {
      try {
        credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        User? user = credential.user;
        if (user != null) {
          UserModel superUser = await userService
              .initializeUserWithEmailAndUID(email, user.uid);

          if (superAdmins.isEmpty) {
            await userService.setSuperAdminRole(superUser.id);
            superUser.role = UserRole.SuperAdmin.name;
          } else if (superAdmins.length > 1) {
            await credential.user!.delete();
            throw Exception('Error Creation Super Admin !!!');

            /*
        MessageWidget.errorMessage(
          context,
          "Error",
          "Impossible de Creer User",
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
        */
          }
          if (!user.emailVerified) {
            await user.sendEmailVerification();
          }
          if (user.emailVerified) {
            superUser.isVerified = true;
          }

          await userService.addModel(superUser);
          await FirebaseAuth.instance.signOut();
        }
      } on FirebaseAuthException {
        throw Exception('Error Creation Super Admin !!!');
      }
    }
  }
}

Future<Map<String, dynamic>> loadConfig() async {
  final jsonString = await rootBundle.loadString('assets/config.json');
  return json.decode(jsonString);
}


// firebase emulators:start --export-on-exit=./emulator-data
// firebase emulators:start --import=./emulator-data