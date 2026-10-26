import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';

class IncompleteModuleConfigurationModel<S extends StoreModel> {
  const IncompleteModuleConfigurationModel({
    required this.store,
    required this.problem,
    required this.problemIcon,
    this.status = true,
  });

  final S store;
  final String problem;
  final IconData? problemIcon;
  final bool? status;
}
