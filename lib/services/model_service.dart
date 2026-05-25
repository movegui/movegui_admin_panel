import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/services/api_service.dart';

abstract class ModelService<T extends Model> {
  final ApiService api;

  ModelService({required this.api});
  Future<T> addModel(T model);
  Future<List<T>> allModels();
  Future<List<T>> getByName(String name);
  String getCollectionName();
}