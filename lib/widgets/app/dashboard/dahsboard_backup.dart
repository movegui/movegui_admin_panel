import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/movegui_colors.dart';
import 'package:movegui_admin_panel/responsive_grid.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/util/menu_tile.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/kpi_card.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/alerts_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/dashbord_models_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/order_status_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/recent_activities_panel.dart';

enum ServiceType { restaurant, pressing, supermarket, pharmacy, delivery }

extension ServiceTypeColor on ServiceType {
  Color color(BuildContext context) {
    final colors = Theme.of(context).extension<MoveGuiColors>()!;

    switch (this) {
      case ServiceType.restaurant:
        return colors.restaurant;

      case ServiceType.pressing:
        return colors.pressing;

      case ServiceType.supermarket:
        return colors.supermarket;

      case ServiceType.pharmacy:
        return colors.pharmacy;

      case ServiceType.delivery:
        return colors.delivery;
    }
  }
}

class MoveGuiAdminDashboardPage extends StatefulWidget {
  const MoveGuiAdminDashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => MoveGuiAdminDashboardPageState();
}

class MoveGuiAdminDashboardPageState extends State<MoveGuiAdminDashboardPage> {
  late final DashboardService service;
  late final Future<DashboardModel> model;

  @override
  void initState() {
    super.initState();

    service = getIt<DashboardService>();
    model = service.loadDashboardItems(FirebaseFirestore.instance);
  }

  void _showCreateMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuTile(
                  title: AppLocalizations.of(context)!.pressing_add_bar_title,
                  icon: Icons.dry_cleaning,
                  enabled: true,
                  routeName: RouteConstants.PRESSING_ROUTE,
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.admin_add_bar_title,
                  icon: Icons.admin_panel_settings,
                  enabled: false,
                  routeName: RouteConstants.ADMIN_ROUTE,
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.manager_add_bar_title,
                  icon: Icons.manage_accounts,
                  enabled: false,
                  routeName: RouteConstants.MANAGER_ROUTE,
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.employe_add_bar_title,
                  icon: Icons.badge,
                  enabled: false,
                  routeName: RouteConstants.EMPLOYE_ROUTE,
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.restaurant_add_bar_title,
                  icon: Icons.restaurant,
                  enabled: false,
                  routeName: RouteConstants.RESTAURANT_ROUTE,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DashboardModel>(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final models = snapshot.data ?? DashboardModel.empty();

          return RefreshIndicator(
            onRefresh: () async {
              // Le FutureBuilder se reconstruit si la page parente appelle setState.
              // Pour un dashboard temps réel, tu peux remplacer FutureBuilder par StreamBuilder.
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DashboardHeader(
                      title: AppLocalizations.of(context)!.dashbord_movegui_title,
                      subtitle: AppLocalizations.of(
                        context,
                      )!.dashbord_movegui_sub_title,
                      onPressed: (item) async {
                        _showCreateMenu(context);
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  itemsWidget(models, service),
                  
                  const SizedBox(height: 12),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isLarge = constraints.maxWidth >= 1000;
                      return Flex(
                        direction: isLarge ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: isLarge ? 2 : 0,
                            child: OrderStatusPanel(models: models),
                          ),
                          SizedBox(
                            width: isLarge ? 24 : 0,
                            height: isLarge ? 0 : 24,
                          ),
                          
                          Expanded(
                            flex: isLarge ? 2 : 0,
                            child: DashboardModelsPanel(models: models),
                          ),
                          
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isLarge = constraints.maxWidth >= 1000;
                      return Flex(
                        direction: isLarge ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: isLarge ? 3 : 0,
                            child: RecentActivitiesPanel(firestore: FirebaseFirestore.instance),
                          ),
                          SizedBox(
                            width: isLarge ? 24 : 0,
                            height: isLarge ? 0 : 24,
                          ),
                          Expanded(
                            flex: isLarge ? 2 : 0,
                            child: AlertsPanel(models: models),
                          ),
                        ],
                      );
                    },
                  ),
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget itemsWidget(DashboardModel stats, DashboardService service) {
  return ResponsiveGrid(
    children: [
      KpiCard(
        title: 'Commandes',
        value: stats.totalOrders.toString(),
        subtitle: '${stats.pendingOrders} en attente',
        icon: Icons.receipt_long_rounded,
        //      color: AppColors.moveGuiRed,
      ),
      KpiCard(
        title: 'Clients',
        value: stats.totalCustomers.toString(),
        subtitle: 'Utilisateurs clients',
        icon: Icons.people_alt_rounded,
        //  color: const Color(0xFF6A1B9A),
      ),
      KpiCard(
        title: 'Livreurs',
        value: stats.totalDrivers.toString(),
        subtitle: '${stats.onlineDrivers} connectés',
        icon: Icons.delivery_dining_rounded,
        //   color: AppColors.infoBlue,
      ),
      KpiCard(
        title: 'Revenus',
        value: service.formatGnf(stats.totalRevenue),
        subtitle: 'Total commandes payées',
        icon: Icons.payments_rounded,
        //  color: AppColors.successGreen,
      ),
    ],
  );
}


/*
class _DashboardError extends StatelessWidget {
  final String message;

  const _DashboardError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 56,
            ),
            const SizedBox(height: 16),
            const Text(
              'Erreur de chargement du dashboard',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
*/
