import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';

class PressingFormController extends StoreFormController<PressingModel> {
     final formKey = GlobalKey<FormState>();
   List<PressingServiceFormController> serviceForms = [PressingServiceFormController()];
  List<PressingServiceModel>? services = [];

  @override
  Future<void> setData(PressingModel model) async {

    await super.setData(model);
    serviceForms.asMap().entries.map((entry) async {
       final index = entry.key;
       final serviceForm = entry.value;
     await  serviceForm.setData(services![index] );
    }).toList();
  }

  @override
  void clear() {
    super.clear();
    for(final serviceForm in serviceForms){
      serviceForm.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
        for(final serviceForm in serviceForms){
      serviceForm.dispose();
    }
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

    for (final serviceForm in serviceForms) {
      if (!serviceForm.isValid()) {
        return false;
      }
    }

    return name.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        email.text.isNotEmpty &&
        description.text.isNotEmpty;
  }
}
