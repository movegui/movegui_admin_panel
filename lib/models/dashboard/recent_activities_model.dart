import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/establishment/store_model.dart';

enum ActivityCategory { order, establishment, user, delivery, payment, system }

enum ActivityType {
  establishment_created,
  establishment_updated,
  establishment_deleted,
  order_created,
  order_updated,
  order_deleted,
}

class RecentActivitiesModel extends Model {
  final StoreType storeType;
  final ActivityCategory category;
  final String title;
  final String? establishmentId;
  final String? userId;
  final String? orderId;
  final Map<String, dynamic> metadata;
  final ActivityType activityType;

  RecentActivitiesModel({
    required this.storeType,
    required this.category,
    required this.title,
    required this.metadata,
    this.establishmentId,
    this.userId,
    this.orderId,
    required super.id,
    required super.name,
    required super.createdAt,
    super.description,
    required this.activityType,
  });

  factory RecentActivitiesModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;

    return RecentActivitiesModel(
      id: document.id,
      storeType: data['type'] as StoreType,
      category: ActivityCategory.values.firstWhere(
        (category) => category.name == data['category'],
        orElse: () => ActivityCategory.system,
      ),
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      establishmentId: data['establishmentId'] as String?,
      userId: data['userId'] as String?,
      orderId: data['orderId'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      metadata: Map<String, dynamic>.from(data['metadata'] as Map? ?? {}),
      name: data['name'],
      activityType: ActivityType.values.firstWhere(
        (value) => value.name == data['activityType'].name,
      ),
    );
  }

  factory RecentActivitiesModel.fromjson(Map<String, dynamic> json) =>
      RecentActivitiesModel(
        storeType: StoreType.values.firstWhere(
          (store) => store.type.name == (json['type'] as StoreType).name,
          orElse: () => StoreType.laundry,
        ),
        category: ActivityCategory.values.firstWhere(
          (category) => category.name == json['category'],
          orElse: () => ActivityCategory.system,
        ),
        title: json['title'],
        metadata: Map<String, dynamic>.from(json['metadata'] as Map? ?? {}),
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        activityType: ActivityType.values.firstWhere(
          (value) => value.name == json['activityType'].name,
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'type': storeType.type.toJson(),
    'category': category,
    'title': title,
    'metadata': metadata,
    'establishmentId': establishmentId,
    'userId': userId,
    'orderId': orderId,
    'activityType': activityType,
  };


}
