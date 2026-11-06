import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';

class IncompleteModuleConfigurationModel<S extends EstablishmentModel> {
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
