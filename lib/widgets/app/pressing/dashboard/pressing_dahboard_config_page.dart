

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_card_stat.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';

class PressingConfigPage extends StatelessWidget {
  const PressingConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(title: "Pressing Élégance", subtitle: "Gestion complète de votre pressing", onPressed: (item) async {}),

            const SizedBox(height: 24),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.8,
              children: const [
                DashboardStatCard(
                  title: "Commandes",
                  value: "52",
                  icon: Icons.receipt_long,
                  color: Colors.blue,
                ),
                DashboardStatCard(
                  title: "Clients",
                  value: "128",
                  icon: Icons.people,
                  color: Colors.green,
                ),
                DashboardStatCard(
                  title: "Employés",
                  value: "8",
                  icon: Icons.badge,
                  color: Colors.orange,
                ),
                DashboardStatCard(
                  title: "Revenus",
                  value: "5.2M GNF",
                  icon: Icons.payments,
                  color: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _ConfigCard(
                  title: "Articles & Tarifs",
                  subtitle: "15 articles configurés",
                  icon: Icons.local_laundry_service,
                  color: Colors.indigo,
                ),
                _ConfigCard(
                  title: "Services",
                  subtitle: "Standard, Express, Premium",
                  icon: Icons.room_service,
                  color: Colors.blue,
                ),
                _ConfigCard(
                  title: "Employés",
                  subtitle: "Gestion du personnel",
                  icon: Icons.groups,
                  color: Colors.orange,
                ),
                _ConfigCard(
                  title: "Livreurs",
                  subtitle: "4 livreurs actifs",
                  icon: Icons.delivery_dining,
                  color: Colors.green,
                ),
                _ConfigCard(
                  title: "Promotions",
                  subtitle: "2 campagnes actives",
                  icon: Icons.local_offer,
                  color: Colors.red,
                ),
                _ConfigCard(
                  title: "Zones Livraison",
                  subtitle: "5 zones configurées",
                  icon: Icons.location_on,
                  color: Colors.teal,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Activités Récentes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                      title: const Text("Commande #CMD-458 terminée"),
                      subtitle: const Text("Il y a 10 minutes"),
                    ),

                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange.shade100,
                        child: const Icon(
                          Icons.local_laundry_service,
                          color: Colors.orange,
                        ),
                      ),
                      title: const Text("Nouveau pressing créé"),
                      subtitle: const Text("Aujourd'hui"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Ajouter"),
      ),
    );
  }

}




class _ConfigCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _ConfigCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),
    );
  }
}
