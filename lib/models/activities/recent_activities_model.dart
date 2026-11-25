import 'package:movegui_admin_panel/models/establishment/establishment_category_model.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/model.dart';

class RecentActivitiesModel extends Model {
  RecentActivitiesModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required this.establishmentType,
    required this.activityType,
    required this.establishmentCategory,
    required this.title,
    required this.establishmentId,
    required this.ownerId,
  });

  final EstablishmentType establishmentType;
  final ActivityType activityType;
  final EstablishmentCategory establishmentCategory;
  final String title;
  final String establishmentId;
  final String ownerId;
}

enum ActivityType {
  establishment_created(
    'establishment_created',
    'created',
    'recent_activity_title',
    'recent_activity_description',
  ),
   establishment_updated(
    'establishment_updated',
    'updated',
    'recent_activity_title',
    'recent_activity_description',
  );

  final String id;
  final String name;
  final String descriptionKey;
  final String titleKey;
  const ActivityType(this.id, this.name, this.titleKey, this.descriptionKey);
}
