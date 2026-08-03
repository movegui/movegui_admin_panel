class DashboardModel {

  final int totalOrders;
  final int pendingOrders;
  final int preparingOrders;
  final int deliveringOrders;
  final int completedOrders;
  final int cancelledOrders;
  final int totalCustomers;
  final int totalDrivers;
  final int onlineDrivers;
  final int restaurants;
  final int pressingOrders;
  final int supermarkets;
  final int pharmacies;
  final num totalRevenue;

  const DashboardModel({
    required this.totalOrders,
    required this.pendingOrders,
    required this.preparingOrders,
    required this.deliveringOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.totalCustomers,
    required this.totalDrivers,
    required this.onlineDrivers,
    required this.restaurants,
    required this.pressingOrders,
    required this.supermarkets,
    required this.pharmacies,
    required this.totalRevenue,
  });

  factory DashboardModel.empty() {
    return const DashboardModel(
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
      pressingOrders: 0,
      supermarkets: 0,
      pharmacies: 0,
      totalRevenue: 0,
    );
  }
}

