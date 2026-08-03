

import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/service_model.dart';

abstract class OrderItemModel<S extends ServiceModel> extends Model {
  final S service;
   int qty;
   double total;
     final Map<String, dynamic>? options;

  OrderItemModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.service,
    required this.qty,
    required this.total,
    this.options
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'service': service.toJson(),
    'qty': qty,
    'total': total,
    'options': options
  };
}
