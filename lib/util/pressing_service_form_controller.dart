import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';
import 'package:movegui_admin_panel/util/pressing_service_type_form_controller.dart';
import 'package:movegui_admin_panel/util/product_form_controller.dart';

class PressingServiceFormController
    extends FormController<PressingServiceModel> {
  final name = TextEditingController();
  final nameFocusNode = FocusNode();
  final minPrice = TextEditingController();
  final minPriceFocusNode = FocusNode();
  final maxPrice = TextEditingController();
  final maxPriceFocusNode = FocusNode();
  PressingServiceTypeModel? serviceType;
  Duration? estimatedDuration;
  final serviceTypeFormController = PressingServiceTypeFormController();
  final articleFormController =  ProductFormController<PressingArticleModel>();
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
}
