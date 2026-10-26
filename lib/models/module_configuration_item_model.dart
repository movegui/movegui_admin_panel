import 'dart:ui';

import 'package:movegui_admin_panel/models/dashboard/module_item.dart';

class ModuleConfigurationItemModel {
  const ModuleConfigurationItemModel({
    required this.item,
    required this.valueLabel,
    required this.buttonLabel,
    this.onPressed,
  });

  final ModuleItem item;
  final String valueLabel;
  final String buttonLabel;
  final VoidCallback? onPressed;
}
