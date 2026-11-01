import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';

class PressingDashboardModelData extends DashboardModelData {
  const PressingDashboardModelData({
    required this.totalPressings,
    required this.activePressings,
    required this.inactivePressings,
    required this.configuredServices,
    required this.serviceTypes,
    required this.configuredOpeningHours,
    required this.incompleteOpeningHours,
    required super.totalOrders,
    required super.pendingOrders,
    required super.preparingOrders,
    required super.deliveringOrders,
    required super.completedOrders,
    required super.cancelledOrders,
    required super.totalCustomers,
    required super.totalDrivers,
    required super.onlineDrivers,
    required super.restaurants,
    required super.pressings,
    required super.supermarkets,
    required super.pharmacies,
    required super.totalRevenue,
  });

  final int totalPressings;
  final int activePressings;
  final int inactivePressings;
  final int configuredServices;
  final int serviceTypes;
  final int configuredOpeningHours;
  final int incompleteOpeningHours;

  factory PressingDashboardModelData.empty() {
    return PressingDashboardModelData(
      totalPressings: 0,
      activePressings: 0,
      inactivePressings: 0,
      configuredServices: 0,
      serviceTypes: 0,
      configuredOpeningHours: 0,
      incompleteOpeningHours: 0,
      totalOrders: 0,
      pendingOrders: 0,
      preparingOrders: 0,
      deliveringOrders: 0,
      completedOrders: 0,
      cancelledOrders: 0,
      totalCustomers: 0,
      totalDrivers: 0,
      onlineDrivers: 0,
      restaurants: 0,
      pressings: 0,
      supermarkets: 0,
      pharmacies: 0,
      totalRevenue: 0,
    );
  }
}
