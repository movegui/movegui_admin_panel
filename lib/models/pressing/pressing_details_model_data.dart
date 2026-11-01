import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';

class PressingDetailsModelData extends DashboardModelData {
  final int totalEmployes;
  final int totalsManagers;
  final int totalsOwners;
  final int totalServices;
  final int totalserviceTypes;
  final int configuredOpeningHours;
  final int totalActifsServices;
  final int totalInactifsServices;

  PressingDetailsModelData({
    required this.totalEmployes,
    required this.totalsManagers,
    required this.totalsOwners,
    required this.totalServices,
    required this.totalserviceTypes,
    required this.configuredOpeningHours,
    required this.totalActifsServices,
    required this.totalInactifsServices,
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

  factory PressingDetailsModelData.empty() {
    return PressingDetailsModelData(
      totalEmployes: 0,
      totalsManagers: 0,
      totalsOwners: 0,
      totalServices: 0,
      totalserviceTypes: 0,
      configuredOpeningHours: 0,
      totalActifsServices: 0,
      totalInactifsServices: 0,
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
