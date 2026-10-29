import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/models/pressing/services_types_dashboard_model.dart';
import 'package:movegui_admin_panel/models/pressing/services_types_dashboard_model_data.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/dashboard_screen.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_type_form_service.dart';
import 'package:movegui_admin_panel/services/pressing_services_types_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/util/pressing_service_type_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/dashboard/model_types_dahsboard_page.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';
import 'package:uuid/uuid.dart';

class PressingServicesTypesScreen extends DashboardScreen {
  PressingServicesTypesScreen({super.key})
    : super(
        pageBuilder: (stats, service) =>
            _PressingDashboardLoader(stats: stats, service: service),
      );
}

class _PressingDashboardLoader extends StatefulWidget {
  const _PressingDashboardLoader({required this.stats, required this.service});

  final DashboardModelData stats;
  final DashboardService service;

  @override
  State<_PressingDashboardLoader> createState() =>
      _PressingDashboardLoaderState();
}

class _PressingDashboardLoaderState extends State<_PressingDashboardLoader> {
  late final Future<ServicesTypesDashboardModel> _dashboardData;
  bool _hasStartedDashboardLoad = false;
  late AppLocalizations _localizations;
  late PressingServiceTypeModel selectedType;
  late PressingServicesTypesService pressingServicesTypesService;
  late PressingServicesTypeFormService pressingServicesTypeFormService;

  @override
  void initState() {
    super.initState();
    pressingServicesTypesService = getIt<PressingServicesTypesService>();
    pressingServicesTypeFormService = getIt<PressingServicesTypeFormService>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context)!;
    if (!_hasStartedDashboardLoad) {
      _hasStartedDashboardLoad = true;
      _dashboardData = _loadDashboardData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ServicesTypesDashboardModel>(
      future: _dashboardData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        final data = snapshot.data!;
        return ModelTypesDahsboardPage<PressingServiceTypeModel>(
          stats: widget.stats,
          service: widget.service,
          staticsItems: data.staticsItems ?? [],
          modules: data.modules ?? [],
          types: data.types,
          selectedType: selectedType,
          onTypeChange: (PressingServiceTypeModel? value) {},
          onSearchChanged: (String value) {},
          onEdit:
              (ModuleConfigurationItemModel<PressingServiceTypeModel> value) {},
          onDelete:
              (ModuleConfigurationItemModel<PressingServiceTypeModel> value) {},
          onChangeStatus:
              (ModuleConfigurationItemModel<PressingServiceTypeModel> module) {
                setState(() {
                  module.item.model?.isActive =
                      !(module.item.model!.isActive ?? false);
                });
              },
          onRegister:
              (List<PressingServiceTypeFormController> controllers) async {
                final addedTypes = await pressingServicesTypeFormService
                    .getModels(controllers);
                if (addedTypes.isNotEmpty) {
                  for (final type in addedTypes) {
                    await pressingServicesTypesService.addModel(type);
                  }
                  final addedModules = await getModules(addedTypes);
                  if (!mounted) return;
                  final typesById = {
                    for (final type in data.types) type.id: type,
                  };
                  for (final type in addedTypes) {
                    typesById[type.id] = type;
                  }

                  final modulesById = {
                    for (final module
                        in data.modules ??
                            <
                              ModuleConfigurationItemModel<
                                PressingServiceTypeModel
                              >
                            >[])
                      module.item.id: module,
                  };
                  for (final module in addedModules) {
                    modulesById[module.item.id] = module;
                  }

                  setState(() {
                    data.types
                      ..clear()
                      ..addAll(typesById.values);
                    data.modules
                      ?..clear()
                      ..addAll(modulesById.values);
                  });
                }
              },
        );
      },
    );
  }

  Future<ServicesTypesDashboardModel> _loadDashboardData() async {
    final allTypes = await getServiceTypes();
    final dashboardData = await _getDashboardData(allTypes);
    final staticsItems = await getStaticItems(dashboardData);
    final modules = await getModules(allTypes);

    return ServicesTypesDashboardModel(
      staticsItems: staticsItems,
      modules: modules,
      types: allTypes,
    );
  }

  Future<List<PressingServiceTypeModel>> getServiceTypes() async {
    List<PressingServiceTypeModel> types = [];
    final savedTypes = await pressingServicesTypesService.allModels();
    types.add(
      PressingServiceTypeModel(
        id: '0999',
        name: _localizations.pressing_services_types_all_title,
        description: _localizations.pressing_services_types_all_descrip,
        pricingType: PricingType.fixed,
        createdAt: DateTime.now(),
        isActive: true,
        colorValue: null,
        iconName: null,
        servicesCount: savedTypes.fold<int>(
          0,
          (total, typ) => total + (typ.servicesCount ?? 0),
        ),
      ),
    );
    types.addAll(savedTypes);

    if (mounted) {
      setState(() {
        selectedType = types[0];
      });
    }
    return types;
  }

  Future<List<ModuleConfigurationItemModel<PressingServiceTypeModel>>>
  getModules(List<PressingServiceTypeModel> servicesTypes) async {
    return servicesTypes
        .map(
          (type) => ModuleConfigurationItemModel<PressingServiceTypeModel>(
            item: ModuleItem(
              value: '${type.servicesCount}',
              icon: type.icon,
              id: type.id,
              name: type.name,
              createdAt: type.createdAt,
              description: type.description,
              isActive: type.isActive,
              model: type,
              color: type.color,
            ),
            valueLabel: AppLocalizations.of(context)!.store_services_title,
            buttonLabel: '',
            options: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.price_type_label,
                    style: Theme.of(context)!.textTheme.bodyMedium?.copyWith(
                      color: Color(0xFF172554),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    type.pricingType?.name ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                      height: 1.45,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .toList();
  }

  Future<List<ModuleItem<PressingServiceTypeModel>>> getStaticItems(
    ServicesTypesDashboardModelData dashboardData,
  ) async {
    return [
      ModuleItem<PressingServiceTypeModel>(
        value: '${dashboardData.totalTypes}',
        icon: Icons.category,
        id: Uuid().v4(),
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_services_types_title,
        createdAt: DateTime.now(),
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_services_types_subtitle,
        isActive: true,
        color: Colors.blue,
      ),
      ModuleItem<PressingServiceTypeModel>(
        name: _localizations.static_module_item_pressing_actifs_title,
        value: '${dashboardData.totalActiveTypes}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_services_types_actifs_subtitle,
        icon: Icons.check_circle_rounded,
        color: const Color(0xFF16A34A),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
      ModuleItem<PressingServiceTypeModel>(
        name: _localizations.static_module_item_pressing_inactifs_title,
        value: '${dashboardData.totalInactiveTypes}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_services_types_inactifs_subtitle,
        icon: Icons.cancel_rounded,
        color: const Color(0xFFDC2626),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
    ];
  }

  Future<ServicesTypesDashboardModelData> _getDashboardData(
    List<PressingServiceTypeModel> servicesTypes,
  ) async {
    final actifs = servicesTypes.where((type) => type.isActive == true).length;
    return ServicesTypesDashboardModelData(
      totalTypes: servicesTypes.length,
      totalActiveTypes: actifs,
      totalInactiveTypes: servicesTypes.length - actifs,
    );
  }
}
