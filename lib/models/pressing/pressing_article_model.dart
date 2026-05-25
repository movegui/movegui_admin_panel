import 'package:movegui_admin_panel/models/model.dart';

class PressingArticleModel extends Model {
  final String? iconUrl;

  PressingArticleModel({
    required super.id,
    required super.name,
    required this.iconUrl,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'iconUrl': iconUrl};

  factory PressingArticleModel.fromJson(Map<String, dynamic> json) =>
      PressingArticleModel(
        id: json['id'],
        name: json['name'],
        iconUrl: json['iconUrl'],
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
      );
}
