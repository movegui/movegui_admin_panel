import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';

class PressingServiceTypeFormController
    extends FormController<PressingServiceTypeModel> {
         final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();
  PricingType? pricingType;
  String? id;
  DateTime? createdAt;

  void dispose() {
    name.dispose();
    description.dispose();
  }

  void clear() {
    name.clear();
    description.clear();
    id = null;
    pricingType = null;
    createdAt = null;
  }

  @override
  Future<void> setData(PressingServiceTypeModel model) async {
    name.text = model.name;
    description.text = model.description;
    pricingType = model.pricingType;
    id = model.id;
    createdAt = model.createdAt;
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
        description.text.isNotEmpty &&
        pricingType != null &&
        createdAt != null &&
        id != null;
  }
}
