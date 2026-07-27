import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

// ignore: non_constant_identifier_names
enum UserRole { Admin, User, Employe, Guest, SuperAdmin, Manager, Support, Driver }

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
  Future<UserModel?> getCurrentUser(BuildContext context, WidgetRef? ref);
  Future<List<UserModel?>> getSuperAdmins();
  //Future<void> setAdminRole(BuildContext context, String uid);
  Future<void> setUserRole(BuildContext context , String uid, String role);
  Future<bool> isAuthorize(UserModel? user);
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
    Future<UserModel?> createUserWithoutPassword(
    String email,
    String role,
    String firstName,
    String lastName,
    List<AdressModel> adresses,
    String phone,
    String gender,
    DateTime birthDate,
  );

    Future<UserModel?> initializeCreatedUserWithLink(
    String uuid,
    String email,
    String? resetLink,
    String role,
    String firstName,
    String lastName,
    List<AdressModel?> addresses,
    String phone,
    String gender,
    DateTime birthDate,
  );
}
