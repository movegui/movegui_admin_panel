import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/incomplete_module_configuration_model.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_dahboard_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/screens/dashboard_screen.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/util/pressing_completion.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/dashboard/pressing_dashboard_page.dart';
import 'package:uuid/uuid.dart';

class PressingScreen extends DashboardScreen {
  PressingScreen({super.key})
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
  late final Future<PressingDashboardModel> _dashboardData;

  @override
  void initState() {
    super.initState();
    _dashboardData = _loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PressingDashboardModel>(
      future: _dashboardData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        final data = snapshot.data!;
        return PressingDashboardPage(
          stats: widget.stats,
          service: widget.service,
          configurationModules: data.configurationModules,
          incompletesPressings: data.incompletesPressings,
          staticsItems: data.staticsItems,
        );
      },
    );
  }

  Future<PressingDashboardModel> _loadDashboardData() async {
    final pressingService = getIt<PressingService>();
    final pressings = await pressingService.allModels();
    final servicesByPressing = await Future.wait(
      pressings.map((pressing) => pressingService.getAllServices(pressing.id)),
    );
    final dashboardData = await getDashboardData(pressings, servicesByPressing);
    final incompletePressings = await getIncompleteModules(
      pressings,
      servicesByPressing,
    );
    final configuredModulles = await getConfiguredModules(dashboardData);
    final staticsItems = await getStaticItems(dashboardData);

    return PressingDashboardModel(
      configurationModules: configuredModulles,
      incompletesPressings: incompletePressings,
      staticsItems: staticsItems,
    );
  }

  Future<PressingDashboardModelData> getDashboardData(
    List<PressingModel> pressings,
    List<List<PressingServiceModel>> servicesByPressing,
  ) async {
    final serviceCount = servicesByPressing.fold<int>(
      0,
      (count, services) => count + services.length,
    );
    final serviceTypeCount = servicesByPressing
        .expand((services) => services)
        .map((service) => service.serviceType.id)
        .toSet()
        .length;
    final configuredHoursCount = pressings
        .where(
          (pressing) => PressingCompletion.hasConfiguredOpeningHours(
            pressing.weeklyHours,
          ),
        )
        .length;
    final activePressingCount = pressings
        .where((pressing) => pressing.isActive == true)
        .length;

    return PressingDashboardModelData(
      totalPressings: pressings.length,
      activePressings: activePressingCount,
      inactivePressings: pressings.length - activePressingCount,
      configuredServices: serviceCount,
      serviceTypes: serviceTypeCount,
      configuredOpeningHours: configuredHoursCount,
      incompleteOpeningHours: pressings.length - configuredHoursCount,
    );
  }

  Future<List<ModuleConfigurationItemModel>> getConfiguredModules(
    PressingDashboardModelData data,
  ) async {
    return [
      ModuleConfigurationItemModel(
        item: ModuleItem(
          name: AppLocalizations.of(
            context,
          )!.module_configuration_item_pressing_title,
          description: AppLocalizations.of(
            context,
          )!.module_configuration_item_pressing_subtitle,
          icon: Icons.dry_cleaning,
          color: const Color(0xFFD81B60),
          value: '${data.totalPressings}',
          id: Uuid().v4(),
          createdAt: DateTime.now(),
          isActive: data.totalPressings > 0,
        ),
        valueLabel: AppLocalizations.of(
          context,
        )!.module_configuration_item_pressing_title,
        buttonLabel: AppLocalizations.of(context)!.btn_manage,
        onPressed: () => context.go(RouteConstants.PRESSING_ALL_ROUTE),
      ),

      ModuleConfigurationItemModel(
        item: ModuleItem(
          name: AppLocalizations.of(
            context,
          )!.module_configuration_item_pressing_type_service_title,
          description: AppLocalizations.of(
            context,
          )!.module_configuration_item_pressing_type_service_subtitle,
          icon: Icons.layers_rounded,
          color: const Color(0xFF1976D2),
          value: '${data.serviceTypes}',
          id: Uuid().v4(),
          createdAt: DateTime.now(),
          isActive: data.serviceTypes > 0,
        ),
        valueLabel: AppLocalizations.of(
          context,
        )!.module_configuration_item_pressing_type_service_title,
        buttonLabel: AppLocalizations.of(context)!.btn_see,
        onPressed: () => context.go(RouteConstants.PRESSING_TYPE_SERVICE_ROUTE),
      ),

      ModuleConfigurationItemModel(
        item: ModuleItem(
          name: AppLocalizations.of(
            context,
          )!.module_configuration_item_pressing_open_hours_title,
          description: AppLocalizations.of(
            context,
          )!.module_configuration_item_pressing_open_hours_subtitle,
          icon: Icons.schedule_rounded,
          color: const Color(0xFF16A34A),
          value: '${data.configuredOpeningHours} / ${data.totalPressings}',
          id: Uuid().v4(),
          createdAt: DateTime.now(),
          isActive: data.configuredOpeningHours > 0 && data.totalPressings > 0,
        ),
        valueLabel: AppLocalizations.of(context)!.pressing_service_configured,
        buttonLabel: AppLocalizations.of(context)!.btn_see,
        onPressed: () => context.go(RouteConstants.PRESSING_ALL_ROUTE), 
      ),

      ModuleConfigurationItemModel(
        item: ModuleItem(
          name: AppLocalizations.of(
            context,
          )!.module_configuration_item_pressing_configured_services_title,
          description: AppLocalizations.of(
            context,
          )!.module_configuration_item_pressing_configured_services_subtitle,
          icon: Icons.local_laundry_service_rounded,
          color: const Color(0xFFF59E0B),
          value: '${data.configuredServices}',
          id: Uuid().v4(),
          createdAt: DateTime.now(),
          isActive: data.configuredServices > 0,
        ),
        valueLabel: AppLocalizations.of(context)!.store_services_title,
        buttonLabel: AppLocalizations.of(context)!.btn_see,
        onPressed: () => context.go(RouteConstants.PRESSING_ALL_ROUTE),
      ),
    ];
  }

  Future<List<IncompleteModuleConfigurationModel<PressingModel>>>
  getIncompleteModules(
    List<PressingModel> pressings,
    List<List<PressingServiceModel>> servicesByPressing,
  ) async {
    List<IncompleteModuleConfigurationModel<PressingModel>>
    incompletePressings = [];
    for (var index = 0; index < pressings.length; index++) {
      final pressing = pressings[index];
      String problems = "";
      final pressingServices = servicesByPressing[index];
      if (pressing.isComplete == true &&
          PressingCompletion.isComplete(
            staff: pressing.staff,
            services: pressingServices,
            weeklyHours: pressing.weeklyHours,
          )) {
        continue;
      }

      if (!PressingCompletion.hasConfiguredOpeningHours(pressing.weeklyHours)) {
        problems =
            '$problems ${AppLocalizations.of(context)!.pressing_problem_hours_non_configured}';
      }
      if (!PressingCompletion.hasActiveService(pressingServices)) {
        problems =
            '$problems ${AppLocalizations.of(context)!.pressing_problem_service_non_configured}';
      }
      if (!PressingCompletion.hasConfiguredStaff(pressing.staff)) {
        if (!PressingCompletion.hasRole(pressing.staff, UserRole.Employe)) {
          problems =
              '$problems ${AppLocalizations.of(context)!.pressing_proble_staff_employe}';
        }
        if (!PressingCompletion.hasRole(pressing.staff, UserRole.Manager)) {
          problems =
              '$problems ${AppLocalizations.of(context)!.pressing_proble_staff_manager}';
        }
        if (!PressingCompletion.hasRole(pressing.staff, UserRole.Employe)) {
          problems =
              '$problems ${AppLocalizations.of(context)!.pressing_proble_staff_owner}';
        }
      }
      if (pressing.isComplete != true) {
        problems =
            '$problems ${AppLocalizations.of(context)!.pressing_problem_incomplete_infos}';
      }
      incompletePressings.add(
        IncompleteModuleConfigurationModel<PressingModel>(
          problem: problems,
          problemIcon: Icons.dangerous,
          store: pressing,
        ),
      );
    }
    return incompletePressings;
  }

  Future<List<ModuleItem>> getStaticItems(
    PressingDashboardModelData data,
  ) async {
    return [
      ModuleItem(
        name: AppLocalizations.of(context)!.static_module_item_pressing_title,
        value: '${data.totalPressings}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_subtitle,
        icon: Icons.apartment_rounded,
        color: const Color(0xFF7047E3),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
      ModuleItem(
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_actifs_title,
        value: '${data.activePressings}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_actifs_subtitle,
        icon: Icons.check_circle_rounded,
        color: const Color(0xFF16A34A),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
      ModuleItem(
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_inactifs_title,
        value: '${data.inactivePressings}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_inactifs_subtitle,
        icon: Icons.cancel_rounded,
        color: const Color(0xFFDC2626),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
      ModuleItem(
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_configured_services_title,
        value: '${data.configuredServices}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_configured_services_subtitle,
        icon: Icons.layers_rounded,
        color: const Color(0xFF1976D2),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
    ];
  }
}
