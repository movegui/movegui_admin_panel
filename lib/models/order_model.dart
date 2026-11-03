

import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/order_item_model.dart';

abstract class OrderModel<T extends OrderItemModel> extends Model {
   List<T> items;
   double total;
   OrderStatus status;
  final String currency;
  String orderId;
  String customerId;
  OrderModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.total,
    required this.items,
    required this.status,
    required this.currency,
    required this.orderId,
    required this.customerId
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'customerId': customerId,
    'items': items.map((item) => item.toJson()).toList(),
    'total': total,
    'status': status.name,
    'orderId': orderId,
    'currency': currency
  };
}

enum OrderStatus { pending, in_progress, accepted, assigned, processing, delivered, completed, picked, cancelled }
