import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/models/types_model.dart';

class TypesDahboardModel<M extends TypesModel> {
  final List<ModuleItem<M>>? staticsItems;
  final List<ModuleConfigurationItemModel<M>>? modules;
  final List<M> types;

  TypesDahboardModel({
    required this.staticsItems,
     this.modules,
    required this.types,
  });
}
