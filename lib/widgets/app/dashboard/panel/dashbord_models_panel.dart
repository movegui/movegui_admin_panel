import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/dashbord_panel.dart';

class DashboardModelsPanel extends StatelessWidget {
  final DashboardModel models;

  const DashboardModelsPanel({super.key, required this.models});

  @override
  Widget build(BuildContext context) {
    return DashboardPanel(
      title: 'Services MoveGui',
      icon: Icons.dashboard_customize_rounded,
      child: Column(
        children: [
          ServiceRow(
            icon: Icons.restaurant,
            label: 'Restaurants',
            value: models.restaurants,
            color: Colors.deepOrange,
          ),
          ServiceRow(
            icon: Icons.local_laundry_service,
            label: 'Pressing',
            value: models.pressingOrders,
            color: Colors.indigo,
          ),
          ServiceRow(
            icon: Icons.storefront,
            label: 'Supermarchés',
            value: models.supermarkets,
            color: Colors.green,
          ),
          ServiceRow(
            icon: Icons.local_pharmacy,
            label: 'Pharmacies',
            value: models.pharmacies,
            color: Colors.teal,
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
        child: Icon(icon, color: color),
      ),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      trailing: Text(
        value.toString(),
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: color,
          fontSize: 18,
        ),
      ),
    );
  }
}