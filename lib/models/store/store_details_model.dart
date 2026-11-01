import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';

class StoreDetailsModel<M extends StoreModel> {

  final List<ModuleItem> staticsItems;
  final M model;

  StoreDetailsModel({required this.staticsItems, required this.model});

}