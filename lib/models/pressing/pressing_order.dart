import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_order_item.dart';

class PressingOrder {
  final String id;
  final List<PressingOrderItem> items;
  final PressingArticleCategory serviceType;
  final DateTime pickupDate;
  final DateTime? deliveryDate;

  PressingOrder({
    required this.id,
    required this.items,
    required this.serviceType,
    required this.pickupDate,
    this.deliveryDate,
  });
}