import 'package:movegui_admin_panel/models/model.dart';

class PressingServiceTypeModel extends Model {
  final String description;
  final PricingType pricingType;

  PressingServiceTypeModel({
    required super.id,
    required super.name,
    required this.description,
    required this.pricingType,
    required super.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PressingServiceTypeModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'description': description,
    'pricingType': pricingType.name,
  };

  factory PressingServiceTypeModel.fromJson(Map<String, dynamic> json) =>
      PressingServiceTypeModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pricingType: PricingType.values.firstWhere(
          (e) => e.name == json['pricingType'],
          orElse: () => PricingType.fixed,
        ),
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
      );
}

enum PricingType { perItem, perKg, fixed }
