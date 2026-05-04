
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/user_model.dart';


  // ignore: non_constant_identifier_names
enum UserRole {
  Admin,
  User,
  Employe,
  Guest
}

abstract class IUserService {
  Future<UserModel?> getByUsername(String username);
  Future<UserModel?> registerWithEmail(BuildContext context, UserModel model, String password);
  Future<void> update(UserModel model);
  Future<UserModel?> getByEmail(String email);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();



}