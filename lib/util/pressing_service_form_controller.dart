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
  final description = TextEditingController();
  final processingTime = TextEditingController();
  final nameFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final processingTimeFocusNode = FocusNode();
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
  bool? active ;
  String? currency = 'GNF';

  void dispose() {
    description.dispose();
    minPrice.dispose();
    maxPrice.dispose();
    serviceTypeFormController.dispose();
    articleFormController.dispose();
    processingTime.dispose();
  }

  void clear() {
    minPrice.clear();
    maxPrice.clear();
    processingTime.clear();
    serviceTypeFormController.clear();
    articleFormController.clear();
    serviceType = null;
    estimatedDuration = null;
    description.clear();
  }

  @override
  Future<void> setData(PressingServiceModel model) async {
    id = model.id;
    minPrice.text = model.minPrice.toString();
    maxPrice.text = model.maxPrice.toString();
    serviceTypeFormController.setData(model.serviceType);
    serviceType = model.serviceType;
    articleFormController.setData(model.product);
    processingTime.text = model.estimatedDuration?.inHours.toString() ?? '';
    createdAt = model.createdAt;
    basePrice = model.basePrice;
    description.text = model.description ?? '';
    active = model.isActive ?? true;
    currency = model.currency ?? 'GNF';
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

    return articleFormController.name.text.isNotEmpty &&
        minPrice.text.isNotEmpty &&
        maxPrice.text.isNotEmpty &&
        serviceType != null &&
        processingTime.text.isNotEmpty &&
        id != null &&
        basePrice != null &&
        createdAt != null;
  }
}
