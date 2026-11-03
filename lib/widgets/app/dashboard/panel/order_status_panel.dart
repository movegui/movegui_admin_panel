import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashbord_cards.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/empty_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/panel_item_widget.dart';

class OrderStatusPanel extends StatelessWidget {
  final DashboardModelData stats;
  final List<ModuleItem>? items;

  const OrderStatusPanel({super.key, required this.stats, this.items});

  @override
  Widget build(BuildContext context) {
    final statusItems =
        items ??
        [
          ModuleItem(
            name: AppLocalizations.of(context)!.dashbord_orders_pending,
            value: '${stats.pendingOrders}',
            color: AppColors.warning,
            icon: Icons.circle_rounded,
            id: '001',
            createdAt: DateTime.now(),
            description: '',
            isActive: true,
          ),
          ModuleItem(
            name: AppLocalizations.of(context)!.dashbord_orders_preparing,
            value: '${stats.preparingOrders}',
            color: AppColors.info,
            icon: Icons.circle_rounded,
            id: '002',
            createdAt: DateTime.now(),
            description: '',
            isActive: true,
          ),
          ModuleItem(
            name: AppLocalizations.of(context)!.dashbord_orders_delivering,
            value: '${stats.deliveringOrders}',
            color: AppColors.on_delivery,
            icon: Icons.circle_rounded,
            id: '003',
            createdAt: DateTime.now(),
            description: '',
            isActive: true,
          ),
          ModuleItem(
            name: AppLocalizations.of(context)!.dashbord_orders_completed,
            value: '${stats.completedOrders}',
            color: AppColors.success,
            icon: Icons.circle_rounded,
            id: '004',
            createdAt: DateTime.now(),
            description: '',
            isActive: true,
          ),
          ModuleItem(
            name: AppLocalizations.of(context)!.dashbord_orders_cancelled,
            value: '${stats.cancelledOrders}',
            color: AppColors.error,
            icon: Icons.circle_rounded,
            id: '005',
            createdAt: DateTime.now(),
            description: '',
            isActive: true,
          ),
        ];

    if (statusItems.isEmpty) {
      return Card(
        child: EmptyPanel(
          icon: Icons.query_stats_rounded,
          title: 'Aucune commande',
          subtitle: 'Il n\'y a pas de commandes à afficher.',
        ),
      );
    }
    return DashBordCards(
      title: AppLocalizations.of(context)!.dashbord_orders_state_title,
      icon: Icons.query_stats_rounded,
      child: Column(
        children: statusItems
            .map(
              (status) => ListTile(
                title: PanelItemWidget(
                  moduleItem: status,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

