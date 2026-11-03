import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashbord_cards.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/panel_item_widget.dart';

class ServicesPanel extends StatelessWidget {
  final DashboardModelData stats;
  final List<ModuleItem>? items;

  const ServicesPanel({super.key, required this.stats, this.items});

  @override
  Widget build(BuildContext context) {
    final servvices =
        items ??
        [
          ModuleItem(
            name:
                AppLocalizations.of(context)?.static_module_item_pressing_title ??
                'Pressing',
            value: '${stats.pressings}',
            color: Colors.indigo,
            icon: Icons.local_laundry_service,
            id: '001',
            createdAt: DateTime.now(),
            description: AppLocalizations.of(context)?.static_module_item_pressing_subtitle ??
                'Pressing',
            isActive: true,
            onTap: () {
              context.push(RouteConstants.PRESSING_ALL_ROUTE);
            },
          ),
          ModuleItem(
            name:
                AppLocalizations.of(context)?.module_restaurant_name ??
                'Restaurants',
            value: '${stats.restaurants}',
            color: AppColors.placeHolderText,
            icon: Icons.restaurant,
            id: '002',
            createdAt: DateTime.now(),
            description: '',
            isActive: false,
          ),
          ModuleItem(
            name:
                AppLocalizations.of(context)?.module_super_market_name ??
                'Supermarchés',
            value: '${stats.supermarkets}',
            color: AppColors.placeHolderText,
            icon: Icons.storefront,
            id: '003',
            createdAt: DateTime.now(),
            description: '',
            isActive: false,
          ),
          ModuleItem(
            name:
                AppLocalizations.of(context)?.module_pharmacy_name ??
                'Pharmacies',
            value: '${stats.pharmacies}',
            color: AppColors.placeHolderText,
            icon: Icons.local_pharmacy,
            id: '004',
            createdAt: DateTime.now(),
            description: '',
            isActive: false,
          ),
        ];
    return DashBordCards(
      title:
          AppLocalizations.of(context)?.dashboard_services_title ??
          'Our Services',
      icon: Icons.dashboard_customize_rounded,
      trailing: TextButton(onPressed: () {}, child: const Text('Voir tout les services')),
      child: Column(
        children: servvices
            .map(
              (service) => ListTile(
                title: PanelItemWidget(
                  moduleItem: service,
                ),
                onTap: service.isActive == true ? service.onTap : (){}
              ),
            )
            .toList(),
      ),
      /*
      Column(
        children: [
          ServiceRow(
            icon: Icons.local_laundry_service,
            label:
                AppLocalizations.of(context)?.module_pressing_name ??
                'Pressing',
            value: stats.pressings,
            color: Colors.indigo,
          ),
          ServiceRow(
            icon: Icons.restaurant,
            label:
                AppLocalizations.of(context)?.module_restaurant_name ??
                'Restaurants',
            value: stats.restaurants,
            color: AppColors.placeHolderText,
          ),

          ServiceRow(
            icon: Icons.storefront,
            label:
                AppLocalizations.of(context)?.module_super_market_name ??
                'Supermarchés',
            value: stats.supermarkets,
            color: AppColors.placeHolderText,
          ),
          ServiceRow(
            icon: Icons.local_pharmacy,
            label:
                AppLocalizations.of(context)?.module_pharmacy_name ??
                'Pharmacies',
            value: stats.pharmacies,
            color: AppColors.placeHolderText,
          ),
        ],
      ),
      */
    );
  }
}
/*
class ServiceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;

  const ServiceRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.12),
        child: Icon(icon),
      ),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      trailing: Text(
        value.toString(),
        style: TextStyle(
          fontWeight: FontWeight.w900,
          //    color: color,
          fontSize: 18,
        ),
      ),
    );
  }
}
*/
