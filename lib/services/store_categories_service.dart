
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/services/categories_service.dart';

class StoreCategoriesService extends CategoriesService<CategoriesModel> {
  StoreCategoriesService({required super.api, required super.fromJson});

  @override
  String getCollectionName() {
    return MoveGuiCollections.COLLECTION_STORE_CATEGORIES;
  }

}
