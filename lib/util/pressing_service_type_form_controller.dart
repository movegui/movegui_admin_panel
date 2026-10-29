import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';
import 'package:uuid/uuid.dart';

class PressingServiceTypeFormController
    extends FormController<PressingServiceTypeModel> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();
  final nameFocusNode = FocusNode();
  final descriptionFocus = FocusNode();
  PricingType? pricingType = PricingType.fixed;
  String? id = Uuid().v4();
  DateTime? createdAt = DateTime.now();
  bool? isActive = true;
  String? iconName = 'dry_cleaning';
   String? colorValue = 'disabled';
   Color? color = AppColors.disabled;
   IconData? icon =  Icons.dry_cleaning;
   int? servicesCount = 0;

  void dispose() {
    name.dispose();
    description.dispose();
    nameFocusNode.dispose();
  }

  void clear() {
    name.clear();
    description.clear();
    id = null;
    pricingType = null;
    createdAt = null;
  }

  @override
  String toString() {
    return 'PressingServiceTypeFormController(name: ${name.text}, '
        'description: ${description.text}, id: $id, '
        'pricingType: $pricingType, createdAt: $createdAt, '
        'isActive: $isActive)';
  }

  @override
  Future<void> setData(PressingServiceTypeModel model) async {
    name.text = model.name;
    description.text = model.description ?? '';
    pricingType = model.pricingType ?? PricingType.perItem;
    id = model.id;
    createdAt = model.createdAt;
    isActive = model.isActive ?? false;
    iconName = model.iconName;
    colorValue = model.colorValue;
    icon = model.icon;
    color = model.color;
    servicesCount = model.servicesCount;



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
