import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/current_user_provider.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/model_service.dart';
import 'package:uuid/uuid.dart';

class UserService extends ModelService<UserModel> implements IUserService {
  final auth = FirebaseAuth.instance;
  UserService({required super.api});

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
    String email,
    String password,
  ) async {
    UserModel? model;
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;
      if (user != null) {
        model = await initializeUserWithEmailAndUID(email, user.uid);
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
        if (user.emailVerified) {
          model.isVerified = true;
        }

        await addModel(model);
        return model;
      }
    } on FirebaseException catch (e) {
      print(e);
      await credential!.user!.delete();
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        AppLocalizations.of(context)!.error_register_with_email_message,
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
  Future<void> signOut(WidgetRef ref) async {
    ref.read(CurrentUserProvider.currentUserProvider).setCurrentUser(null);
    await FirebaseAuth.instance.signOut();

  }

  Future<UserModel> initializeUserWithEmailAndUID(
    String email,
    String uuid,
  ) async {
    late UserModel currentUser;

    currentUser = UserModel(
      updatedAt: DateTime.now(),
      id: uuid,
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
      role: UserRole.Guest.name,
    );
    return currentUser;
  }

  @override
  Future<UserModel?> getCurrentUser(WidgetRef? ref) async {
    if (ref != null) {
      final currentUser = ref
          .watch(CurrentUserProvider.currentUserProvider)
          .currentUser;
      if (currentUser != null) return currentUser;
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userModel = await getByEmail(user.email!);
        if (userModel != null) {
          final idTokenResult = await user.getIdTokenResult(true);
          final role = idTokenResult.claims?['role'];
          if (role != null && role == userModel.role) {
            ref
                .read(CurrentUserProvider.currentUserProvider)
                .setCurrentUser(userModel);
            return userModel;
          }
        }
      }
    }
    /*
    return null;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel? userModel = await getByEmail(user.email!);
      if (userModel != null) {
        final idTokenResult = await user.getIdTokenResult(true);
        final role = idTokenResult.claims?['role'];
        print('claims is $role');
        if (role != null && role == userModel.role) {
          return userModel;
        }
      }
    }
*/
    return null;
  }

  @override
  Future<void> setSuperAdminRole(String uid) async {
    try {
      final url = Uri.parse(
        //'https://us-central1-movegui-253e0.cloudfunctions.net/setSuperAdminRole',
        //'https://setsuperadminrole-b2xn772ova-uc.a.run.app',
        //'http://127.0.0.1:5001/movegui-253e0/us-central1/setSuperAdminRole',
        '${api.env.baseUrl}/movegui-253e0/us-central1/setSuperAdminRole',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'role': UserRole.SuperAdmin.name}),
      );
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        print('Error: ${response.body}');
      }
    } on Exception {
      await FirebaseAuth.instance.currentUser?.delete();
      throw Exception('Error User Creation !!!');
      /*
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        AppLocalizations.of(context)!.error_register_with_email_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
      */
    }
  }

  @override
  Future<void> setAdminRole(BuildContext context, String uid) async {
    try {} on Exception {
      await FirebaseAuth.instance.currentUser?.delete();
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        AppLocalizations.of(context)!.error_register_with_email_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
    final url = Uri.parse(
      //  'https://us-central1-movegui-253e0.cloudfunctions.net/setAdminRole',
      // 'http://127.0.0.1:5001/movegui-253e0/us-central1/setAdminRole',
      '${api.env.baseUrl}/movegui-253e0/us-central1/setAdminRole',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'role': UserRole.Admin}),
    );
    if (response.statusCode == 200) {
      print('Success: ${response.body}');
    } else {
      print('Error: ${response.body}');
    }
  }

  @override
  Future<List<UserModel?>> getSuperAdmins() async {
    final firestore = FirebaseFirestore.instance;

    final snapshot = await firestore
        .collection(getCollectionName())
        .where('role', isEqualTo: UserRole.SuperAdmin.name)
        .get();

    if (snapshot.docs.isEmpty) return [];

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  @override
  Future<bool> isAuthorize(UserModel? user) async {
    if (user == null) return false;
    if (user.role == UserRole.SuperAdmin.name ||
        user.role == UserRole.Admin.name ||
        user.role == UserRole.Employe.name) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> isSuperUser(BuildContext context, WidgetRef ref) async {
    final currentUser = ref
        .read(CurrentUserProvider.currentUserProvider)
        .currentUser;
    if (currentUser == null) return false;
    if (currentUser.role != UserRole.SuperAdmin.name) return false;
    return true;
  }

    @override
  Future<bool> isAdmin(BuildContext context, WidgetRef ref) async {
    final currentUser = ref
        .read(CurrentUserProvider.currentUserProvider)
        .currentUser;
    if (currentUser == null) return false;
    if (currentUser.role != UserRole.Admin.name) return false;
    return true;
  }

  @override
  Future<UserModel?> getCurrentUserByMail(String email, WidgetRef ref) async {
    final currentUser = ref
        .read(CurrentUserProvider.currentUserProvider)
        .currentUser;
    if (currentUser != null) return currentUser;
    final notifier = ref.read(CurrentUserProvider.currentUserProvider);
    final newCurrentUser = await getByEmail(email);
    if (newCurrentUser != null) {
      notifier.setCurrentUser(newCurrentUser);
    }
    return newCurrentUser;
  }

  @override
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
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    final idToken = await user?.getIdToken();

    final response = await http.post(
      Uri.parse('${api.env.baseUrl}/movegui-253e0/us-central1/createUser'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: jsonEncode({'email': email, 'password': password, 'role': role}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data.length > 0) {
         return await initializeCreatedUser(data['uid'], email, password, role, firstName, lastName, adresses, phone, gender, birthDate);
      }
    }
    return null;
  }
  
  @override
  Future<UserModel?> initializeCreatedUser(String uuid, String email, String password, String role, String firstName, String lastName, List<AdressModel> addresses, String phone, String gender, DateTime birthDate) async{
            return UserModel(
          updatedAt: DateTime.now(),
          id: uuid,
          name: email,
          createdAt: DateTime.now(),
          username: email,
          isVerified: false,
          role: role,
          personModel: PersonModel(
            id: Uuid().v4(),
            name: "$firstName $lastName",
            createdAt: DateTime.now(),
            firstName: firstName,
            lastName: lastName,
            profileImageUrl: null,
            email: email,
            phone: phone,
            gender: gender,
            birthDate: birthDate,
            addresses: addresses,
          ),
        );
  }
  
  @override
  Future<List<UserModel>> getAllModelsByRole(UserRole role) async {
        final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('role', isEqualTo: role.name)
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }



  /*
  @override
  Future<void> createSuperUser(BuildContext context,  UserModel? user) async{
            final superAdmins = await getSuperAdmins();
        if (superAdmins.isEmpty) {
          await setSuperAdminRole(context, user!.id);
          user.role = UserRole.SuperAdmin.name;
        } else if (superAdmins.length > 1) {
          MessageWidget.errorMessage(
            context,
            AppLocalizations.of(context)!.error_register_with_phone_title,
            AppLocalizations.of(context)!.error_application,
            Icon(Icons.error, color: AppColors.error),
            FlushbarPosition.TOP,
          );
          return;
        }
  }
  */
}
