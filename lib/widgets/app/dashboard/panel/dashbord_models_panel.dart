import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/dashbord_panel.dart';

class DashboardModelsPanel extends StatelessWidget {
  final DashboardModel models;

  const DashboardModelsPanel({super.key, required this.models});

  @override
  Widget build(BuildContext context) {
    return DashboardPanel(
      title:
          AppLocalizations.of(context)?.dashboard_services_title ??
          'Our Services',
      icon: Icons.dashboard_customize_rounded,
      child: Column(
        children: [
          ServiceRow(
            icon: Icons.local_laundry_service,
            label:
                AppLocalizations.of(context)?.module_pressing_name ??
                'Pressing',
            value: models.pressings,
            color: Colors.indigo,
          ),
          ServiceRow(
            icon: Icons.restaurant,
            label:
                AppLocalizations.of(context)?.module_restaurant_name ??
                'Restaurants',
            value: models.restaurants,
            color: AppColors.placeHolderText,
          ),

          ServiceRow(
            icon: Icons.storefront,
            label:
                AppLocalizations.of(context)?.module_super_market_name ??
                'Supermarchés',
            value: models.supermarkets,
            color: AppColors.placeHolderText,
          ),
          ServiceRow(
            icon: Icons.local_pharmacy,
            label:
                AppLocalizations.of(context)?.module_pharmacy_name ??
                'Pharmacies',
            value: models.pharmacies,
            color: AppColors.placeHolderText,
          ),
        ],
      ),
    );
  }
}

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
        child: Icon(icon,),
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
