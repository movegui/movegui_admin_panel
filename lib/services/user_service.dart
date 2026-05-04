// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/model_service.dart';
import 'package:uuid/uuid.dart';

class UserService extends ModelService<UserModel> implements IUserService {
  final auth = FirebaseAuth.instance;
  @override
  Future<void> addModel(UserModel model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .set(model.toJson());
  }

  @override
  Future<List<UserModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  @override
  Future<List<UserModel>> getByName(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('name', isEqualTo: name)
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  @override
  String getCollectionName() {
    return "users";
  }

  @override
  Future<UserModel?> getByUsername(String username) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('username', isEqualTo: username)
        .get();

    if (snapshot.docs.isEmpty) return null;

    return UserModel.fromJson(snapshot.docs.first.data());
  }

  @override
  Future<UserModel?> registerWithEmail(
    BuildContext context,
    UserModel model,
    String password,
  ) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: model.personModel!.email!,
            password: password,
          );
      User? user = credential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      if (user!.emailVerified) {
        model.isVerified = true;
      }
      await addModel(model);
      return model;
    } on FirebaseException {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        AppLocalizations.of(context)!.error_register_with_phone_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
    return null;
  }

  @override
  Future<UserModel?> getByEmail(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('person.email', isEqualTo: email.trim().toLowerCase())
        .get();

    if (snapshot.docs.isEmpty) return null;
    return UserModel.fromJson(snapshot.docs.first.data());
  }

  Future<UserModel> getById(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception("User not found");
    }
    return UserModel.fromJson(snapshot.data()!);
  }

  @override
  Future<void> update(UserModel model) async {
    return FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .update(model.toJson());
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserModel> initializeUserWithEmail(String email) async {
    late UserModel currentUser;

    currentUser = UserModel(
      updatedAt: DateTime.now(),
      id: Uuid().v4(),
      name: email,
      createdAt: DateTime.now(),
      username: email,
      isVerified: false,
      personModel: PersonModel(
        id: Uuid().v4(),
        name: '',
        createdAt: DateTime.now(),
        firstName: '',
        lastName: '',
        profileImageUrl: null,
        email: email,
        phone: null,
        gender: '',
        birthDate: null,
        addresses: [],
      ),
      role: UserRole.Guest,
    );
    return currentUser;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel? userModel = await getByEmail(user.email!);
      if (userModel != null) {
        final idTokenResult = await user.getIdTokenResult();
        final role = idTokenResult.claims?['role'];
        if (role != null && role == userModel.role) {
          return userModel;
        }
      }
    }
    return null;
  }
}
