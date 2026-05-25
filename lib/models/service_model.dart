import 'package:movegui_admin_panel/models/model.dart';

abstract class ServiceModel extends Model{
  
  ServiceModel({required super.id, required super.name, required super.createdAt});

  
  String getCollectionName();
}