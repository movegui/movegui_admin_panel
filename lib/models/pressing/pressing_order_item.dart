import 'package:movegui_admin_panel/models/order_item_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';

class PressingOrderItem extends OrderItemModel<PressingServiceModel> {
  PressingOrderItem({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.service,
    required super.qty,
    required super.total,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory PressingOrderItem.fromJson(Map<String, dynamic> json) =>
      PressingOrderItem(
        total: json['total'],
        id: json['id'] ?? '001',
        name: json['name'] ?? 'sev1',
        createdAt:
            json['createdAt'] != null
                ? json['createdAt'].toDate()
                : DateTime.now(),
        service: PressingServiceModel.fromJson(json['service']),
        qty: json['qty'],
      );
}
