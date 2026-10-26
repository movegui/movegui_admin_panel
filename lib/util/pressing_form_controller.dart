import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/util/pressing_completion.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';

class PressingFormController extends StoreFormController<PressingModel> {
     final formKey = GlobalKey<FormState>();
 final List<PressingServiceModel>? services = [];

        bool get isPressingCompleted => PressingCompletion.isComplete(
        staff: staff,
        services: services,
        weeklyHours: weeklyHours,
        );

  @override
  Future<void> setData(PressingModel model) async {
    await super.setData(model);
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

    return name.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        email.text.isNotEmpty &&
        description.text.isNotEmpty &&
        services!.isNotEmpty;

  }
}
