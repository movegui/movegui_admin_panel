import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';

class PressingOrderItem {
  final String id;
  final PressingArticleCategory category;
  final int quantity;
  final Map<String, dynamic>? options;

  PressingOrderItem({
    required this.id,
    required this.category,
    required this.quantity,
    this.options,
  });
}