import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/models/service_model.dart';

class PressingServiceModel extends ServiceModel {
  final PressingArticleModel article;
  final PressingServiceTypeModel serviceType;
  final double? minPrice;
  final double? maxPrice;
  final double? basePrice;
  final bool? active;
  final Duration? estimatedDuration;

  PressingServiceModel({
    required super.id,
    required this.article,
    required this.serviceType,
    required this.minPrice,
    required this.maxPrice,
    required this.basePrice,
    this.active = true,
    required this.estimatedDuration,
    required super.name,
    required super.createdAt,
  });

  @override
  String getCollectionName() {
    return 'services';
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'article': article.toJson(),
    'serviceType': serviceType.toJson(),
    'minPrice': minPrice,
    'maxPrice': maxPrice,
    'basePrice': basePrice,
    'active': active,
    'estimatedDuration': estimatedDuration != null ? estimatedDuration!.inMicroseconds : 0,
  };

  factory PressingServiceModel.fromJson(Map<String, dynamic> json) =>
      PressingServiceModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        article: PressingArticleModel.fromJson(json['article']),
        serviceType: PressingServiceTypeModel.fromJson(json['serviceType']),
        minPrice: json['minPrice'],
        maxPrice: json['maxPrice'],
        basePrice: json['basePrice'],
        estimatedDuration: json['estimatedDuration'],
      );
}
