import 'package:movegui_admin_panel/models/product_model.dart';

class PressingArticleModel extends ProductModel {
  PressingArticleModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.price,
    required super.supplierId,
    required super.imageUrl,
    required super.category,
    required super.isAvailable,
    required super.currency,
  });
  

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  


  factory PressingArticleModel.fromJson(Map<String, dynamic> json) =>
      PressingArticleModel(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'] ?? '',
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        supplierId: json['supplierId'],
        category: json['category'] ?? '',
        isAvailable: json['isAvailable'] ?? false,
        price: json['price'] ?? 0,
        currency: json['currency'] ?? 'GNF',
      );
}
