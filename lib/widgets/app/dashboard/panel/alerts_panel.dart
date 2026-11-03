import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashbord_cards.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/empty_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/panel_item_widget.dart';

class AlertsPanel extends StatelessWidget {
  final List<ModuleItem> modules;

  const AlertsPanel({super.key, required this.modules});

  @override
  Widget build(BuildContext context) {
    return DashBordCards(
      title: 'Alertes',
      icon: Icons.notifications_active_rounded,
      child: modules.isEmpty
          ? const EmptyPanel(
              icon: Icons.verified_rounded,
              title: 'Tout est normal',
              subtitle: 'Aucune alerte importante pour le moment.',
            )
          : Column(
              children: modules
                  .map((module) => PanelItemWidget(moduleItem: module))
                  .toList(),
            ),
    );
  }
}

class AlertTile extends StatelessWidget {
  final ModuleItem moduleItem;
  const AlertTile({super.key, required this.moduleItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: moduleItem.color!.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: moduleItem.color!.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(moduleItem.icon, color: moduleItem.color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  moduleItem.value,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),

                const SizedBox(height: 3),
                Text(
                  moduleItem.description ?? '',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
