import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/dashbord_panel.dart';

class OrderStatusPanel extends StatelessWidget {
  final DashboardModel models;

  const OrderStatusPanel({super.key, required this.models});

  @override
  Widget build(BuildContext context) {
    return DashboardPanel(
      title: AppLocalizations.of(context)!.dashbord_orders_state_title,
      icon: Icons.query_stats_rounded,
      child: Column(
        children: [
          StatusRow(
            label: AppLocalizations.of(context)!.dashbord_orders_pending,
            value: models.pendingOrders,
            color: AppColors.warning,
          ),
          StatusRow(
            label: AppLocalizations.of(context)!.dashbord_orders_preparing,
            value: models.preparingOrders,
            color: AppColors.info,
          ),
          StatusRow(
            label: AppLocalizations.of(context)!.dashbord_orders_delivering,
            value: models.deliveringOrders,
            color: AppColors.on_delivery,
          ),
          StatusRow(
            label: AppLocalizations.of(context)!.dashbord_orders_completed,
            value: models.completedOrders,
            color: AppColors.success,
          ),
          StatusRow(
            label: AppLocalizations.of(context)!.dashbord_orders_cancelled,
            value: models.cancelledOrders,
            color: AppColors.error,
          ),
        ],
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const StatusRow({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: color,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}