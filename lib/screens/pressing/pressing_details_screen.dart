import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_details_model_data.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/store/store_details_model.dart';
import 'package:movegui_admin_panel/screens/dashboard_screen.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_details_page.dart';
import 'package:uuid/uuid.dart';

class PressingDetailsScreen extends DashboardScreen {
  final String storeId;
  PressingDetailsScreen({super.key, required this.storeId})
    : super(
        pageBuilder: (stats, service) => _PressingDashboardLoader(
          stats: stats,
          service: service,
          storeId: storeId,
        ),
      );
}

class _PressingDashboardLoader extends StatefulWidget {
  const _PressingDashboardLoader({
    required this.stats,
    required this.service,
    required this.storeId,
  });

  final DashboardModelData stats;
  final DashboardService service;
  final String storeId;

  @override
  State<_PressingDashboardLoader> createState() =>
      _PressingDashboardLoaderState();
}

class _PressingDashboardLoaderState extends State<_PressingDashboardLoader> {
  late final Future<StoreDetailsModel> _dashboardData;

  @override
  void initState() {
    super.initState();
    _dashboardData = _loadDashboardData(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoreDetailsModel>(
      future: _dashboardData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        final data = snapshot.data!;

        return StoreDetailsPage(
          staticsItems: data.staticsItems,
          model: data.model,
          stats: widget.stats,
          service: widget.service,
        );
      },
    );
  }

  Future<StoreDetailsModel> _loadDashboardData(String id) async {
    final pressingService = getIt<PressingService>();
    final pressing = await pressingService.getModelById(id);
    final services = await pressingService.getAllServices(pressing.id);
    final dashboardData = await getDashboardData(pressing, services);
    final staticsItems = await getStaticItems(dashboardData);

    return StoreDetailsModel(model: pressing, staticsItems: staticsItems);
  }

  Future<PressingDetailsModelData> getDashboardData(
    PressingModel pressing,
    List<PressingServiceModel> services,
  ) async {
    final totalEmployes = (pressing.staff ?? [])
        .where((elem) => elem.role == UserRole.Employe)
        .length;
    final totalsManagers = (pressing.staff ?? [])
        .where((elem) => elem.role == UserRole.Employe)
        .length;
    final totalsOwners = (pressing.staff ?? [])
        .where((elem) => elem.role == UserRole.Employe)
        .length;
    final totalServices = services.length;
    final totalActifsServices = services
        .where((service) => service.isActive == true)
        .length;
    final totalserviceTypes = services
        .map((service) => service.serviceType.id)
        .toSet()
        .length;
    final configuredOpeningHours = pressing.weeklyHours
        .where((hour) => hour.isOpen && hour.slots.isNotEmpty)
        .length;

    return PressingDetailsModelData(
      totalEmployes: totalEmployes,
      totalsManagers: totalsManagers,
      totalsOwners: totalsOwners,
      totalServices: totalServices,
      totalserviceTypes: totalserviceTypes,
      configuredOpeningHours: configuredOpeningHours,
      totalActifsServices: totalActifsServices,
      totalInactifsServices: totalServices - totalActifsServices,
      totalOrders: 0,
      pendingOrders: 0,
      preparingOrders: 0,
      deliveringOrders: 0,
      completedOrders: 0,
      cancelledOrders: 0,
      totalCustomers: 0,
      totalDrivers: 0,
      onlineDrivers: 0,
      restaurants: 0,
      pressings: 0,
      supermarkets: 0,
      pharmacies: 0,
      totalRevenue: 0,
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

  Future<List<ModuleItem>> getStaticItems(PressingDetailsModelData data) async {
    return [
      ModuleItem(
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_owners_title,
        value: '${data.totalsOwners}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_owners_subtitle,
        icon: Icons.apartment_rounded,
        color: const Color(0xFF7047E3),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
      ModuleItem(
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_managers_title,
        value: '${data.totalsManagers}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_managers_subtitle,
        icon: Icons.apartment_rounded,
        color: const Color(0xFF7047E3),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
      ModuleItem(
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_employes_title,
        value: '${data.totalEmployes}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_employes_subtitle,
        icon: Icons.apartment_rounded,
        color: const Color(0xFF7047E3),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
      ModuleItem(
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_total_services_title,
        value: '${data.totalServices}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_total_services_subtitle,
        icon: Icons.layers_rounded,
        color: const Color(0xFF1976D2),
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        isActive: true,
      ),
      ModuleItem(
        name: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_actifs_title,
        value: '${data.totalActifsServices}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_services_actifs_subtitle,
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
        value: '${data.totalInactifsServices}',
        description: AppLocalizations.of(
          context,
        )!.static_module_item_pressing_services_inactifs_subtitle,
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
        value: '${data.totalServices}',
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
