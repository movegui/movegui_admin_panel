import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/dashbord_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/empty_stat_panel.dart';

class AlertsPanel extends StatelessWidget {
  final DashboardModel models;

  const AlertsPanel({super.key, required this.models});

  @override
  Widget build(BuildContext context) {
    final alerts = <Widget>[
      if (models.pendingOrders > 0)
        AlertTile(
          icon: Icons.hourglass_top_rounded,
          title: '${models.pendingOrders} commandes en attente',
          subtitle: 'À traiter rapidement',
          color: AppColors.warning,
        ),
      if (models.totalDrivers > 0 && models.onlineDrivers == 0)
        const AlertTile(
          icon: Icons.delivery_dining,
          title: 'Aucun livreur connecté',
          subtitle: 'Vérifier la disponibilité des livreurs',
          color: AppColors.error,
        ),
      if (models.cancelledOrders > 0)
        AlertTile(
          icon: Icons.cancel_rounded,
          title: '${models.cancelledOrders} commandes annulées',
          subtitle: 'Analyser les raisons d’annulation',
          color: AppColors.error,
        ),
    ];

    return DashboardPanel(
      title: 'Alertes',
      icon: Icons.notifications_active_rounded,
      child: alerts.isEmpty
          ? const EmptyStatePanel(
              icon: Icons.verified_rounded,
              title: 'Tout est normal',
              subtitle: 'Aucune alerte importante pour le moment.',
            )
          : Column(children: alerts),
    );
  }
}

class AlertTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const AlertTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 3),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}