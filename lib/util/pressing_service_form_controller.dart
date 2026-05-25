import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';

class PressingServiceFormController extends FormController<PressingServiceModel> {
  final name = TextEditingController();
  final nameFocusNode = FocusNode();
  final minPrice = TextEditingController();
  final minPriceFocusNode = FocusNode();
  final maxPrice = TextEditingController();
  final maxPriceFocusNode = FocusNode();
  PressingServiceTypeModel? serviceType ;
  Duration? estimatedDuration;

  void dispose() {
    name.dispose();
    minPrice.dispose();
    maxPrice.dispose();
  }

  void clear() {
    name.clear();
    minPrice.clear();
    maxPrice.clear();
    serviceType = null;
    estimatedDuration = null;
  }
  
  @override
  Future<void> setData(PressingServiceModel model) async {
    name.text = model.article.name;
    minPrice.text = model.minPrice.toString();
    maxPrice.text = model.maxPrice.toString();
  }

}
