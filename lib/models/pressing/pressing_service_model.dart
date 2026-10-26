import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/models/service_model.dart';

class PressingServiceModel extends ServiceModel<PressingArticleModel> {
  final PressingServiceTypeModel serviceType;

  PressingServiceModel({
    required super.id,
    required this.serviceType,
    required super.minPrice,
    required super.maxPrice,
    required super.basePrice,
    super.isActive,
    super.estimatedDuration,
    required super.name,
    required super.createdAt,
    required super.product,
    required super.description,
    super.currency = 'GNF'
  });

  @override
  String getCollectionName() {
    return 'services';
  }

  static String collectionName() {
    return 'services';
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'serviceType': serviceType.toJson(),
  };

  factory PressingServiceModel.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'] ?? json['article'];

    return PressingServiceModel(
        id: json['id'] ?? '001',
        name: json['name'] ?? 'sev1',
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        product: PressingArticleModel.fromJson(
          _requiredJsonMap(productJson, 'product/article'),
        ),
        serviceType: PressingServiceTypeModel.fromJson(
          _requiredJsonMap(json['serviceType'], 'serviceType'),
        ),
        minPrice: json['minPrice'] ?? 0.0,
        maxPrice: json['maxPrice'] ?? 0.0,
        basePrice: json['basePrice'] ?? 0.0,
        estimatedDuration: json['estimatedDuration'] == 0
            ? Duration()
            : Duration(),
        description: json['description'] ?? '',
        currency: json['currency'] ?? 'GNF',
        isActive: json['isActive'] ?? false
      );
  }
}

Map<String, dynamic> _requiredJsonMap(Object? value, String field) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  throw FormatException('Missing or invalid "$field" map in pressing service.');
}
