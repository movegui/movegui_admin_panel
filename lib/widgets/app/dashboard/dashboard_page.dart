import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/movegui_colors.dart';
import 'package:movegui_admin_panel/responsive_grid.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/util/menu_tile.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/kpi_card.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/alerts_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/link_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/order_evolution_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/order_status_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/recent_activities_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/recent_order_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/services_panel.dart';
import 'package:movegui_admin_panel/widgets/util/section_container_widget.dart';
import 'package:movegui_admin_panel/widgets/util/section_title_widget.dart';
import 'package:uuid/uuid.dart';

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

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.stats, required this.service});
  final DashboardModelData stats;
  final DashboardService service;

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
                  title: AppLocalizations.of(context)!.btn_add_pressing,
                  icon: Icon(Icons.dry_cleaning),
                  enabled: true,
                  routeName: RouteConstants.PRESSING_ADD_ROUTE,
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.restaurant_add_bar_title,
                  icon: Icon(Icons.restaurant),
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
    return RefreshIndicator(
      onRefresh: () async {},
      child: Column(
        children: [
          DashboardHeader(
            title: AppLocalizations.of(context)!.dashbord_movegui_title,
            subtitle: AppLocalizations.of(context)!.dashbord_movegui_sub_title,
            onPressed: (item) async {
              _showCreateMenu(context);
            },
          ),

          const SizedBox(height: 12),
          Expanded(
            child: MoveGuiOverviewPage(
              stats: stats,
              service: service,
              onShowCreateMenu: () => _showCreateMenu(context),
            ),
          ),
        ],
      ),
    );
  }
}

Widget itemsWidget(DashboardModelData stats, DashboardService service) {
  return ResponsiveGrid(
    children: [
      KpiCard(
        item: ModuleItem(
          name: 'Commandes',
          value: stats.totalOrders.toString(),
          description: '${stats.pendingOrders} en attente',
          icon: Icons.receipt_long_rounded,
          id: Uuid().v4(),
          createdAt: DateTime.now(),
          isActive: true,
        ),
      ),
      KpiCard(
        item: ModuleItem(
          name: 'Clients',
          value: stats.totalCustomers.toString(),
          description: 'Utilisateurs clients',
          icon: Icons.people_alt_rounded,
          id: Uuid().v4(),
          createdAt: DateTime.now(),
          isActive: true,
        ),
      ),
      KpiCard(
        item: ModuleItem(
          name: 'Livreurs',
          value: stats.totalDrivers.toString(),
          description: '${stats.onlineDrivers} connectés',
          icon: Icons.delivery_dining_rounded,
          id: Uuid().v4(),
          createdAt: DateTime.now(),
          isActive: true,
        ),
      ),
      KpiCard(
        item: ModuleItem(
          name: 'Revenus',
          value: service.formatGnf(stats.totalRevenue),
          description: 'Total commandes payées',
          icon: Icons.payments_rounded,
          id: Uuid().v4(),
          createdAt: DateTime.now(),
          isActive: true,
        ),
      ),
    ],
  );
}

class MoveGuiOverviewPage extends StatelessWidget {
  const MoveGuiOverviewPage({
    super.key,
    required this.stats,
    required this.service,
    this.onShowCreateMenu,
  });
  final DashboardModelData stats;
  final DashboardService service;
  final VoidCallback? onShowCreateMenu;


  @override
  Widget build(BuildContext context) {
    return SectionContainerWidget(
      color: AppColors.background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: _Dashboard(
              width: constraints.maxWidth,
              stats: stats,
              service: service,
              onShowCreateMenu: onShowCreateMenu,
            ),
          );
        },
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  final double width;
  final DashboardModelData stats;
  final DashboardService service;
  final VoidCallback? onShowCreateMenu;

  const _Dashboard({
    required this.width,
    required this.stats,
    required this.service,
    this.onShowCreateMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(
          title: 'Vue ensemble',
          subtitle:
              'Suivez les informations essentielles de votre activité MoveGui.',
          icon: Icons.dashboard_customize_rounded,
          childs: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calendar_today_outlined),
              label: const Text("Aujourd'hui"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
              ),
            ),
          ],
        ),

        // _buildHeader(),
        const SizedBox(height: WidgetConstants.sepWidget * 2),

        // KPI
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 1100 ? 4 : 2;

            return GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.3,
              children: [
                KpiCard(
                  item: ModuleItem(
                    name: 'Commandes',
                    value: '142',
                    description: '+12% vs. hier',
                    icon: Icons.receipt_long,
                    color: Color(0xFFA3171F),
                    //  iconBackground: Color(0xFFFCE8E8),
                    id: '001',
                    createdAt: DateTime.now(),
                    isActive: false,
                  ),
                ),
                KpiCard(
                  item: ModuleItem(
                    name: 'Clients',
                    value: '98',
                    description: '+8% vs. hier',
                    icon: Icons.people_alt_rounded,
                    color: Color(0xFF2196F3),
                    //   iconBackground: Color(0xFFE3F2FD),
                    id: '002',
                    createdAt: DateTime.now(),
                    isActive: true,
                  ),
                ),
                KpiCard(
                  item: ModuleItem(
                    name: 'Établissements',
                    value: '24',
                    description: '+2 actifs',
                    icon: Icons.store_rounded,
                    color: Color(0xFF22A447),
                    //      iconBackground: Color(0xFFE5F7EA),
                    id: '003',
                    createdAt: DateTime.now(),
                    isActive: true,
                  ),
                ),
                KpiCard(
                  item: ModuleItem(
                    name: 'Revenus',
                    value: '256 400 GNF',
                    description: '+15% vs. hier',
                    icon: Icons.monetization_on_rounded,
                    color: Color(0xFFF28C18),
                    //     iconBackground: Color(0xFFFFF2DE),
                    id: '004',
                    createdAt: DateTime.now(),
                    isActive: true,
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: WidgetConstants.sepWidget * 2),

        LayoutBuilder(
          builder: (context, constraints) {
            final horizontal = constraints.maxWidth >= 1000;

            if (!horizontal) {
              return Column(
                children: [
                  OrderEvolutionPanel(),
                  SizedBox(height: WidgetConstants.sepWidget),
                  OrderStatusPanel(stats: stats),
                  SizedBox(height: WidgetConstants.sepWidget),
                  ServicesPanel(stats: stats),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: OrderEvolutionPanel()),
                SizedBox(width: 16),
                Expanded(flex: 3, child: OrderStatusPanel(stats: stats)),
                SizedBox(width: 16),
                Expanded(flex: 3, child: ServicesPanel(stats: stats)),
              ],
            );
          },
        ),

        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 900) {
              return Column(
                children: [
                  const RecentOrderPanel(orders: []),
                  const SizedBox(height: 16),
                  RecentActivitiesPanel(firestore: FirebaseFirestore.instance),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 6, child: RecentOrderPanel(orders: [])),
                const SizedBox(width: 16),
                Expanded(
                  flex: 4,
                  child: RecentActivitiesPanel(
                    firestore: FirebaseFirestore.instance,
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 900) {
              return Column(
                children: [
                  const AlertsPanel(modules: []),
                  const SizedBox(height: 16),
                  LinkPanel(onShowCreateMenu: onShowCreateMenu),
                ],
              );
            }

            return Row(
              children: [
                const Expanded(child: AlertsPanel(modules: [])),
                const SizedBox(width: 16),
                Expanded(child: LinkPanel(onShowCreateMenu: onShowCreateMenu)),
              ],
            );
          },
        ),
      ],
    );
  }
}
