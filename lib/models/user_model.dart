

import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';

class UserModel extends Model {
  final String? username;
  final DateTime? updatedAt;
  final PersonModel? personModel;
  late bool isVerified;
  late String role;
  String? resetLink;
  bool isActive;

  UserModel({
    required this.updatedAt,
    required super.id,
    required super.name,
    required super.createdAt,
    required this.username,
    this.personModel,
    required this.isVerified,
    required this.role,
    this.resetLink = '',
    this.isActive = true,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'username': username,
    'updatedAt': updatedAt,
    'person': personModel!.toJson(),
    'isVerified': isVerified,
    'role': role,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    createdAt: json['createdAt'].toDate() ?? '',
    username: json['username'] ?? '',
    updatedAt: json['updatedAt'].toDate() ?? '',
    personModel: PersonModel.fromJson(json['person']),
    isVerified: json['isVerified'] ?? false,
    role: json['role'] ?? ''
  );
}
