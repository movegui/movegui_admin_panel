import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashbord_cards.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/empty_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/panel_item_name.dart';

class LinkPanel extends StatelessWidget {
  final List<ModuleItem>? items;
  final VoidCallback?  onShowCreateMenu;

  const LinkPanel({
    super.key,
    this.items,
    this.onShowCreateMenu,
  });

  @override
  Widget build(BuildContext context) {
    final modules = items ?? [
      ModuleItem(
        icon: Icons.business,
        name: 'Ajouter un établissement',
        color: AppColors.burgundy,
        onTap: () => onShowCreateMenu?.call(),
        value: '',
        id: '',
        createdAt: DateTime.now(),
        description: '',
        isActive: true,
      ),
      ModuleItem(
        icon: Icons.people,
        name: 'Gérer les utilisateurs',
        color: Colors.blue,
        onTap: () => onShowCreateMenu?.call(),
        value: '',
        id: '',
        createdAt: DateTime.now(),
        description: '',
        isActive: false,
      ),
      ModuleItem(
        icon: Icons.local_shipping,
        name: 'Configurer la livraison',
        color: Colors.green,
        onTap: () => onShowCreateMenu?.call(),
        value: '',
        id: '',
        createdAt: DateTime.now(),
        description: '',
        isActive: false,
      ),
      ModuleItem(
        icon: Icons.bar_chart,
        name: 'Voir les rapports',
        color: Colors.purple,
        onTap: () => onShowCreateMenu?.call(),
        value: '',
        id: '',
        createdAt: DateTime.now(),
        description: '',
        isActive: false,
      ),
    ];

    if (modules.isEmpty) {
      return Card(
        child: EmptyPanel(
          icon: Icons.query_stats_rounded,
          title: 'Aucun Lien',
          subtitle: 'Il n\'y a pas de liens à afficher.',
        ),
      );
    }

    return DashBordCards(
      title: 'Liens rapides',
      icon: Icons.bolt,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: modules
            .map((module) => PanelItemName(moduleItem: module))
            .toList(),
      ),
    );
  }
}


