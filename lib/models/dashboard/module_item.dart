import 'package:flutter/material.dart';

class ModuleItem {
  const ModuleItem({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    this.color,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color? color;
}
