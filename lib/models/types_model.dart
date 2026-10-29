import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:uuid/uuid.dart';

class TypesModel extends Model {
  TypesModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.isActive,
    required super.iconName,
    required super.colorValue,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory TypesModel.fromJson(Map<String, dynamic> json) => TypesModel(
    id: json['id'],
    name: json['name'],
    description: json['description'] ?? '',
    createdAt: json['createdAt'] != null
        ? json['createdAt'].toDate()
        : DateTime.now(),
    iconName: json['iconName'] ?? 'dry_cleaning',
    colorValue: json['colorValue'] ?? AppColors.disabled,
    isActive: json['isActive'] ?? false,
  );

  static TypesModel empty() => TypesModel(
    id: Uuid().v4(),
    name: 'default',
    createdAt: DateTime.now(),
    description: '',
    isActive: false,
    iconName: '',
    colorValue: '',
  );

  IconData get icon {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'settings':
        return Icons.settings;
      case 'person':
        return Icons.person;
      case 'checkroom':
        return Icons.checkroom;
      case 'local_laundry_service_outlined':
        return Icons.local_laundry_service_outlined;
      case 'iron_outlined':
        return Icons.iron_outlined;
      case 'dry_cleaning_outlined':
        return Icons.dry_cleaning_outlined;
      case 'dry_cleaning':
        return Icons.dry_cleaning;
      case 'local_laundry_service':
        return Icons.local_laundry_service;
      case 'iron':
        return Icons.iron;
      case 'bolt':
        return Icons.bolt;
      case 'inventory_2':
        return Icons.inventory_2;
      case 'cleaning_services':
        return Icons.cleaning_services;
      case 'water_drop':
        return Icons.water_drop;
      default:
        return Icons.dry_cleaning;
    }
  }

  Color get color {
    switch (colorValue) {
      case 'disabled':
        return AppColors.disabled;
      case 'blue':
        return Colors.blue;
      case 'teal':
        return Colors.teal;
      case 'orange':
        return Colors.orange;
      case 'deepPurple':
        return Colors.deepPurple;
      case 'purple':
        return Colors.purple;
      case 'indigo':
        return Colors.indigo;
      case 'amber':
        return Colors.amber;
      case 'red':
        return Colors.red;
      case 'cyan':
        return Colors.cyan;
      default:
        return AppColors.disabled;
    }
  }
}
