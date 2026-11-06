import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/establishment_category_model.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';


class PressingModel extends EstablishmentModel {
  PressingModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.address,
    required super.email,
    required super.imageUrl,
    required super.phone,
    required super.weeklyHours,
    required super.establishmentType,
    required super.rating,
    required super.reviewCount,
    required super.establishmentCategory,
    super.isComplete,
    super.isActive,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory PressingModel.fromJson(Map<String, dynamic> json) {
    final addressJson = json['address'];
    if (addressJson is! Map) {
      throw FormatException(
        'Missing or invalid "address" map in pressing "${json['id']}".',
      );
    }

    final rawStoreType = json['establishmentType'];
    final String normalizedStoreTypeId = rawStoreType is Map
        ? (rawStoreType['id'] as String? ?? rawStoreType['name'] as String? ?? 'other')
        : (rawStoreType is String ? rawStoreType : 'other');

    return PressingModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'] ?? '',
      address: AdressModel.fromJson(Map<String, dynamic>.from(addressJson)),
      email: json['email'] ?? '',
      phone: json['telephon'] ?? '',
      createdAt: json['createdAt'] != null
          ? json['createdAt'].toDate()
          : DateTime.now(),
      weeklyHours: (json['weeklyHours'] as List? ?? [])
          .map((e) => OpenHoursModel.fromJson(e))
          .toList(),
      establishmentType: EstablishmentType.values.firstWhere(
          (store) => store.id == normalizedStoreTypeId || store.name == normalizedStoreTypeId,
          orElse: () => EstablishmentType.other,
        ),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      isComplete: json['isComplete'] is bool
          ? json['isComplete'] as bool
          : false,
      isActive: json['isActive'] is bool ? json['isActive'] as bool : false,
      establishmentCategory: EstablishmentCategoryModel.fromJson(json['establishmentCategory'])
    );
  }
}
