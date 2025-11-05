import 'package:movegui_admin_panel/models/model.dart';

abstract class ModelService<T extends Model> {
  Future<void> addModel(T model);
  Future<List<T>> allModels();
  Future<List<T>> getByName(String name);
  String getCollectionName();
}