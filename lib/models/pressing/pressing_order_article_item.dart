import 'package:movegui_admin_panel/models/order_item_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';

class PressingOrderArticleItem extends OrderItemModel<PressingServiceModel> {
  PressingOrderArticleItem({
    required super.id,
    super.options,
    required super.name,
    required super.createdAt,
    required super.service,
    required super.qty,
    required super.total,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory PressingOrderArticleItem.fromJson(Map<String, dynamic> json) =>
      PressingOrderArticleItem(
        service: PressingServiceModel.fromJson(json['service']),
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        qty: json['quantity'],
        options: json['options'] != null
            ? Map<String, dynamic>.from(json['options'])
            : null,
        total: json['total'],
      );
}
