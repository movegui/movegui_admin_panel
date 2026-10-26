
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/incomplete_module_configuration_model.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';

class PressingDashboardModel {
  const PressingDashboardModel({
    required this.configurationModules,
    required this.incompletesPressings,
    required this.staticsItems,
  });

  final List<ModuleConfigurationItemModel> configurationModules;
  final List<IncompleteModuleConfigurationModel<PressingModel>>
  incompletesPressings;
  final List<ModuleItem> staticsItems;
}