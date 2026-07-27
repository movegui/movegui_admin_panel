import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/movegui_colors.dart';
import 'package:movegui_admin_panel/responsive_grid.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/kpi_card.dart';

/// MoveGui Admin Dashboard
///
/// À placer par exemple dans :
/// lib/admin/pages/movegui_admin_dashboard_page.dart
///
/// Dépendance nécessaire : cloud_firestore
///
/// Collections utilisées par défaut :
/// - orders
/// - users
/// - drivers
/// - activities
/// - restaurants
/// - pressing_orders
/// - supermarkets
/// - pharmacies
///
/// Tu peux adapter les noms des collections dans [MoveGuiCollections].
/// 
enum ServiceType {
  restaurant,
  pressing,
  supermarket,
  pharmacy,
  delivery,
}

extension ServiceTypeColor on ServiceType {
  Color color(BuildContext context) {
    final colors = Theme.of(context)
        .extension<MoveGuiColors>()!;

    switch (this) {
      case ServiceType.restaurant:
        return colors.restaurant;

      case ServiceType.pressing:
        return colors.pressing;

      case ServiceType.supermarket:
        return colors.supermarket;

      case ServiceType.pharmacy:
        return colors.pharmacy;

      case ServiceType.delivery:
        return colors.delivery;
    }
  }
}

class MoveGuiAdminDashboardPage extends StatelessWidget {
  const MoveGuiAdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: FutureBuilder<AdminDashboardStats>(
        future: _loadDashboardStats(firestore),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _DashboardError(message: snapshot.error.toString());
          }

          final stats = snapshot.data ?? AdminDashboardStats.empty();

          return RefreshIndicator(
            onRefresh: () async {
              // Le FutureBuilder se reconstruit si la page parente appelle setState.
              // Pour un dashboard temps réel, tu peux remplacer FutureBuilder par StreamBuilder.
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardHeader(
                    title: 'Dashboard MoveGui',
                    subtitle:
                        'Vue globale des commandes, revenus et utilisateurs',
                    onCreatePressed: () {
                      _showCreateMenu(context);
                    },
                  ),

                  /*
                  const SizedBox(height: 24),

                  itemsWidget(stats),

                  const SizedBox(height: 28),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isLarge = constraints.maxWidth >= 1000;
                      return Flex(
                        direction: isLarge ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: isLarge ? 2 : 0,
                            child: OrderStatusPanel(stats: stats),
                          ),
                          SizedBox(
                            width: isLarge ? 24 : 0,
                            height: isLarge ? 0 : 24,
                          ),
                          Expanded(
                            flex: isLarge ? 2 : 0,
                            child: ServiceStatsPanel(stats: stats),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isLarge = constraints.maxWidth >= 1000;
                      return Flex(
                        direction: isLarge ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: isLarge ? 3 : 0,
                            child: RecentActivitiesPanel(firestore: firestore),
                          ),
                          SizedBox(
                            width: isLarge ? 24 : 0,
                            height: isLarge ? 0 : 24,
                          ),
                          Expanded(
                            flex: isLarge ? 2 : 0,
                            child: AlertsPanel(stats: stats),
                          ),
                        ],
                      );
                    },
                  ),
                  */
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget itemsWidget(AdminDashboardStats stats) {
    return ResponsiveGrid(
      children: [
        KpiCard(
          title: 'Commandes',
          value: stats.totalOrders.toString(),
          subtitle: '${stats.pendingOrders} en attente',
          icon: Icons.receipt_long_rounded,
    //      color: AppColors.moveGuiRed,
        ),
        KpiCard(
          title: 'Clients',
          value: stats.totalCustomers.toString(),
          subtitle: 'Utilisateurs clients',
          icon: Icons.people_alt_rounded,
        //  color: const Color(0xFF6A1B9A),
        ),
        KpiCard(
          title: 'Livreurs',
          value: stats.totalDrivers.toString(),
          subtitle: '${stats.onlineDrivers} connectés',
          icon: Icons.delivery_dining_rounded,
       //   color: AppColors.infoBlue,
        ),
        KpiCard(
          title: 'Revenus',
          value: _formatGnf(stats.totalRevenue),
          subtitle: 'Total commandes payées',
          icon: Icons.payments_rounded,
        //  color: AppColors.successGreen,
        ),
      ],
    );
  }

  static Future<AdminDashboardStats> _loadDashboardStats(
    FirebaseFirestore firestore,
  ) async {
    /*
    final results = await Future.wait<int>([
      
      _count(firestore.collection(MoveGuiCollections.orders)),
      _count(firestore.collection(MoveGuiCollections.orders).where('status', isEqualTo: OrderStatus.pending)),
      _count(firestore.collection(MoveGuiCollections.orders).where('status', isEqualTo: OrderStatus.preparing)),
      _count(firestore.collection(MoveGuiCollections.orders).where('status', isEqualTo: OrderStatus.delivering)),
      _count(firestore.collection(MoveGuiCollections.orders).where('status', isEqualTo: OrderStatus.completed)),
      _count(firestore.collection(MoveGuiCollections.orders).where('status', isEqualTo: OrderStatus.cancelled)),
      _count(firestore.collection(MoveGuiCollections.users).where('role', isEqualTo: 'customer')),
      _count(firestore.collection(MoveGuiCollections.drivers)),
      _count(firestore.collection(MoveGuiCollections.drivers).where('online', isEqualTo: true)),
      _count(firestore.collection(MoveGuiCollections.restaurants)),
      _count(firestore.collection(MoveGuiCollections.pressingOrders)),
      _count(firestore.collection(MoveGuiCollections.supermarkets)),
      _count(firestore.collection(MoveGuiCollections.pharmacies)),
      
    ]);
    

    final revenue = await _sumRevenue(firestore);
    */

    return AdminDashboardStats(
      totalOrders: 2, // results[0],
      pendingOrders: 2, //results[1],
      preparingOrders: 2, //results[2],
      deliveringOrders: 2, //results[3],
      completedOrders: 2, //results[4],
      cancelledOrders: 2, //results[5],
      totalCustomers: 2, //results[6],
      totalDrivers: 2, //results[7],
      onlineDrivers: 2, //results[8],
      restaurants: 2, //results[9],
      pressingOrders: 2, //results[10],
      supermarkets: 2, //results[11],
      pharmacies: 2, //results[12],
      totalRevenue: 1000, //revenue,
    );
  }

  static Future<int> _count(Query<Map<String, dynamic>> query) async {
    final snapshot = await query.count().get();
    return snapshot.count ?? 0;
  }

  static Future<num> _sumRevenue(FirebaseFirestore firestore) async {
    // MVP simple : charge les commandes payées et additionne totalAmount.
    // Si tu as beaucoup de commandes, mieux vaut stocker les statistiques dans une collection dashboard_stats
    // avec Cloud Functions.
    final snapshot = await firestore
        .collection(MoveGuiCollections.orders)
        .where('paymentStatus', isEqualTo: 'paid')
        .get();

    num total = 0;
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final amount = data['totalAmount'];
      if (amount is num) total += amount;
    }
    return total;
  }

  static String _formatGnf(num value) {
    final raw = value.round().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < raw.length; i++) {
      final reverseIndex = raw.length - i;
      buffer.write(raw[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(' ');
      }
    }
    return '${buffer.toString()} GNF';
  }

  static void _showCreateMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _CreateMenuTile(
                  icon: Icons.restaurant,
                  title: 'Ajouter un restaurant',
                ),
                _CreateMenuTile(
                  icon: Icons.local_laundry_service,
                  title: 'Ajouter un pressing',
                ),
                _CreateMenuTile(
                  icon: Icons.delivery_dining,
                  title: 'Ajouter un livreur',
                ),
                _CreateMenuTile(
                  icon: Icons.person_add,
                  title: 'Ajouter un employé',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MoveGuiCollections {
  static const String orders = 'orders';
  static const String users = 'users';
  static const String drivers = 'drivers';
  static const String activities = 'activities';
  static const String restaurants = 'restaurants';
  static const String pressingOrders = 'pressing_orders';
  static const String supermarkets = 'supermarkets';
  static const String pharmacies = 'pharmacies';
}

class OrderStatus {
  static const String pending = 'pending';
  static const String preparing = 'preparing';
  static const String delivering = 'delivering';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
}

class AdminDashboardStats {
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

  const AdminDashboardStats({
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

  factory AdminDashboardStats.empty() {
    return const AdminDashboardStats(
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



class OrderStatusPanel extends StatelessWidget {
  final AdminDashboardStats stats;

  const OrderStatusPanel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return DashboardPanel(
      title: 'État des commandes',
      icon: Icons.query_stats_rounded,
      child: Column(
        children: [
          StatusRow(
            label: 'En attente',
            value: stats.pendingOrders,
            color: AppColors.warning,
          ),
          StatusRow(
            label: 'En préparation',
            value: stats.preparingOrders,
            color: AppColors.info,
          ),
          StatusRow(
            label: 'En livraison',
            value: stats.deliveringOrders,
            color: const Color(0xFF7B1FA2),
          ),
          StatusRow(
            label: 'Terminées',
            value: stats.completedOrders,
            color: AppColors.success,
          ),
          StatusRow(
            label: 'Annulées',
            value: stats.cancelledOrders,
            color: AppColors.error,
          ),
        ],
      ),
    );
  }
}

class ServiceStatsPanel extends StatelessWidget {
  final AdminDashboardStats stats;

  const ServiceStatsPanel({super.key, required this.stats});

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
            value: stats.restaurants,
            color: Colors.deepOrange,
          ),
          ServiceRow(
            icon: Icons.local_laundry_service,
            label: 'Pressing',
            value: stats.pressingOrders,
            color: Colors.indigo,
          ),
          ServiceRow(
            icon: Icons.storefront,
            label: 'Supermarchés',
            value: stats.supermarkets,
            color: Colors.green,
          ),
          ServiceRow(
            icon: Icons.local_pharmacy,
            label: 'Pharmacies',
            value: stats.pharmacies,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}

class RecentActivitiesPanel extends StatelessWidget {
  final FirebaseFirestore firestore;

  const RecentActivitiesPanel({super.key, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return DashboardPanel(
      title: 'Activités récentes',
      icon: Icons.history_rounded,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection(MoveGuiCollections.activities)
            .orderBy('createdAt', descending: true)
            .limit(8)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const EmptyState(
              icon: Icons.inbox_rounded,
              title: 'Aucune activité récente',
              subtitle: 'Les nouvelles actions apparaîtront ici.',
            );
          }

          return Column(
            children: docs.map((doc) {
              final data = doc.data();
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.error.withOpacity(0.1),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppColors.error,
                  ),
                ),
                title: Text(
                  (data['title'] ?? 'Activité MoveGui').toString(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text((data['description'] ?? '').toString()),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class AlertsPanel extends StatelessWidget {
  final AdminDashboardStats stats;

  const AlertsPanel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final alerts = <Widget>[
      if (stats.pendingOrders > 0)
        AlertTile(
          icon: Icons.hourglass_top_rounded,
          title: '${stats.pendingOrders} commandes en attente',
          subtitle: 'À traiter rapidement',
          color: AppColors.warning,
        ),
      if (stats.totalDrivers > 0 && stats.onlineDrivers == 0)
        const AlertTile(
          icon: Icons.delivery_dining,
          title: 'Aucun livreur connecté',
          subtitle: 'Vérifier la disponibilité des livreurs',
          color: AppColors.error,
        ),
      if (stats.cancelledOrders > 0)
        AlertTile(
          icon: Icons.cancel_rounded,
          title: '${stats.cancelledOrders} commandes annulées',
          subtitle: 'Analyser les raisons d’annulation',
          color: AppColors.error,
        ),
    ];

    return DashboardPanel(
      title: 'Alertes',
      icon: Icons.notifications_active_rounded,
      child: alerts.isEmpty
          ? const EmptyState(
              icon: Icons.verified_rounded,
              title: 'Tout est normal',
              subtitle: 'Aucune alerte importante pour le moment.',
            )
          : Column(children: alerts),
    );
  }
}

class DashboardPanel extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const DashboardPanel({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.error),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            child,
          ],
        ),
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

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 42, color: Colors.black26),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _CreateMenuTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}

class _DashboardError extends StatelessWidget {
  final String message;

  const _DashboardError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 56,
            ),
            const SizedBox(height: 16),
            const Text(
              'Erreur de chargement du dashboard',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
