import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

// ignore: non_constant_identifier_names
enum UserRole { Admin, User, Employe, Guest, SuperAdmin }

abstract class IUserService {
  Future<UserModel?> getByUsername(String username);
  Future<UserModel?> registerWithEmail(
    BuildContext context,
    String email,
    String password,
  );
  Future<void> update(UserModel model);
  Future<UserModel?> getByEmail(String email);
  Future<void> signOut(WidgetRef ref);
  Future<UserModel?> getCurrentUser(WidgetRef? ref);
  Future<List<UserModel?>> getSuperAdmins();
  Future<void> setAdminRole(BuildContext context, String uid);
  Future<void> setSuperAdminRole(String uid);
  Future<bool> isAuthorize(UserModel? user);
  //  Future<void> createSuperUser(BuildContext context, UserModel? user);
  Future<bool> isSuperUser(BuildContext context, WidgetRef ref);
  Future<UserModel?> getCurrentUserByMail(String email, WidgetRef ref);
  Future<UserModel?> createUser(
    String email,
    String password,
    String role,
    String firstName,
    String lastName,
    List<AdressModel> adresses,
    String phone,
    String gender,
    DateTime birthDate,
  );
  Future<UserModel?> initializeCreatedUser(
    String uuid,
    String email,
    String password,
    String role,
    String firstName,
    String lastName,
    List<AdressModel> adresses,
    String phone,
    String gender,
    DateTime birthDate,
  );
  Future<bool> isAdmin(BuildContext context, WidgetRef ref);
  Future<List<UserModel>> getAllModelsByRole(UserRole role);
}
