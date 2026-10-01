import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/form_services/person_form_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';

class UserFormController extends FormController<UserModel> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final personForm = PersonFormController();
  DateTime? updatedAt = DateTime.now();
  DateTime? createdAt = DateTime.now();
  String? name = '';
  PersonModel? personModel;
  bool? isVerified = false;
  UserRole? role = UserRole.Guest;
  String? resetLink = '';
  bool? isActive = false;

  void dispose() {
    username.dispose();
    personForm.dispose();
  }

  void clear() {
    username.clear();
    personForm.clear();
    updatedAt = null;
    personModel = null;
    isVerified = null;
    role = null;
    resetLink = null;
    isActive = null;
  }

  @override
  Future<void> setData(UserModel model) async {
    final service = getIt<PersonFormService>();
    username.text = model.username ?? '';
    updatedAt = model.updatedAt ?? DateTime.now();
    isActive = model.isActive;
    isVerified = model.isVerified;
    role = model.role;
    resetLink = model.resetLink;
    name = model.name;
    createdAt = model.createdAt;
    personModel = model.personModel;
    await personForm.setData(model.personModel ?? service.getDefaultModel());
  }

  @override
  bool isValid() {
    final currentState = formKey.currentState;
    if (currentState == null) {
      return false;
    }

    if (!currentState.validate()) {
      return false;
    }

    if (!personForm.isValid()) {
      return false;
    }
    

    return username.text.isNotEmpty &&
        name != null &&
        role != null &&
        createdAt != null &&
        updatedAt != null;
  }

  
}
