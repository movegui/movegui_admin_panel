
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/user_model.dart';


  // ignore: non_constant_identifier_names
enum UserRole {
  Admin,
  User,
  Employe,
  Guest,
  SuperAdmin
}

abstract class IUserService {
  Future<UserModel?> getByUsername(String username);
  Future<UserModel?> registerWithEmail(BuildContext context, String email, String password);
  Future<void> update(UserModel model);
  Future<UserModel?> getByEmail(String email);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<List<UserModel?>> getSuperAdmins();
  Future<void> setAdminRole(BuildContext context, String uid);
  Future<void> setSuperAdminRole(BuildContext context, String uid);
  Future<bool> isAuthorize(UserModel? user);
  



}