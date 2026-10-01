import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';
import 'package:movegui_admin_panel/util/pressing_service_type_form_controller.dart';
import 'package:movegui_admin_panel/util/product_form_controller.dart';

class PressingServiceFormController
    extends FormController<PressingServiceModel> {
         final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final nameFocusNode = FocusNode();
  final minPrice = TextEditingController();
  final minPriceFocusNode = FocusNode();
  final maxPrice = TextEditingController();
  final maxPriceFocusNode = FocusNode();
  PressingServiceTypeModel? serviceType;
  Duration? estimatedDuration;
  final serviceTypeFormController = PressingServiceTypeFormController();
  final articleFormController = ProductFormController<PressingArticleModel>();
  String? id;
  double? basePrice;
  DateTime? createdAt;

  void dispose() {
    name.dispose();
    minPrice.dispose();
    maxPrice.dispose();
    serviceTypeFormController.dispose();
    articleFormController.dispose();
  }

  void clear() {
    name.clear();
    minPrice.clear();
    maxPrice.clear();
    serviceTypeFormController.clear();
    articleFormController.clear();
    serviceType = null;
    estimatedDuration = null;
  }

  @override
  Future<void> setData(PressingServiceModel model) async {
    id = model.id;
    name.text = model.product.name;
    minPrice.text = model.minPrice.toString();
    maxPrice.text = model.maxPrice.toString();
    serviceTypeFormController.setData(model.serviceType);
    articleFormController.setData(model.product);
    estimatedDuration = model.estimatedDuration;
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

    if (!serviceTypeFormController.isValid()) {
      return false;
    }

    if (!articleFormController.isValid()) {
      return false;
    }

    return name.text.isNotEmpty &&
        minPrice.text.isNotEmpty &&
        maxPrice.text.isNotEmpty &&
        serviceType != null &&
        estimatedDuration != null &&
        id != null &&
        basePrice != null &&
        createdAt != null;
  }
}