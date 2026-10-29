import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/model.dart';

class ModuleConfigurationItemModel<M extends Model> {
  const ModuleConfigurationItemModel({
    required this.item,
    required this.valueLabel,
    required this.buttonLabel,
    this.onPressed,
    this.options
  });

  final ModuleItem<M> item;
  final String valueLabel;
  final String buttonLabel;
  final VoidCallback? onPressed;
  final List<Widget>? options;
}
