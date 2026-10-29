import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/model.dart';

class ModuleItem<T extends Model> extends Model {
  ModuleItem({
    required this.value,
    required this.icon,
    this.color,
    this.model,
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.isActive
  });

  final String value;
  final IconData icon;
  final Color? color;
  final T? model;
}
