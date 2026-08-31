import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';


class PressingScreen extends ConsumerWidget {
  const PressingScreen({super.key,});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return PressingDashboardPage();
 //   PressingConfigPage();


/*
        return  PressingPage(
        addModelWidget: MainPageWidget(
          buttonItem: ButtonInfo(
            title: AppLocalizations.of(context)!.add,
            enabled: true,
            routeName: RouteConstants.PRESSING_ADD_ROUTE, 
          ),
        ),
        allModelWidget: MainPageWidget(
          buttonItem: ButtonInfo(
           title: AppLocalizations.of(context)!.add_all,
            enabled: true,
            routeName: RouteConstants.PRESSING_ALL_ROUTE,
          ),
        ),
    );
  */

  }
}

class PressingPage extends MainPage {
  const PressingPage({
    super.key,
    required super.addModelWidget,
    required super.allModelWidget,
  });
}





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
            _buildHeader(),

            const SizedBox(height: 24),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.8,
              children: const [
                _StatCard(
                  title: "Commandes",
                  value: "52",
                  icon: Icons.receipt_long,
                  color: Colors.blue,
                ),
                _StatCard(
                  title: "Clients",
                  value: "128",
                  icon: Icons.people,
                  color: Colors.green,
                ),
                _StatCard(
                  title: "Employés",
                  value: "8",
                  icon: Icons.badge,
                  color: Colors.orange,
                ),
                _StatCard(
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

  Widget _buildHeader() {
    return Card(
      elevation: 0,
      color: const Color(0xFFEFF4FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.local_laundry_service),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pressing Élégance",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Gestion complète de votre pressing",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
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

class PressingDashboardPage extends StatelessWidget {
   PressingDashboardPage({super.key});

  final pressings = [{"city":"aas" , "orders": 1, "employeeCount":1}, {"city":"aas" , "orders": 1, "employeeCount":1}, {"city":"aas" , "orders": 1, "employeeCount":1}];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gestion des Pressings",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Administration globale des pressings MoveGui",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Nouveau Pressing"),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// STATS
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: width < 900 ? 2 : 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
              children: const [
                DashboardStatCard(
                  title: "Pressings",
                  value: "24",
                  icon: Icons.store,
                  color: Colors.blue,
                ),
                DashboardStatCard(
                  title: "Commandes",
                  value: "1 284",
                  icon: Icons.receipt_long,
                  color: Colors.orange,
                ),
                DashboardStatCard(
                  title: "Employés",
                  value: "83",
                  icon: Icons.groups,
                  color: Colors.green,
                ),
                DashboardStatCard(
                  title: "Revenus",
                  value: "58M GNF",
                  icon: Icons.payments,
                  color: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// SERVICES
            Text(
              "Services Disponibles",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _serviceCard(
                  title: "Pressing",
                  icon: Icons.local_laundry_service,
                  count: 24,
                  color: Colors.blue,
                ),
                _serviceCard(
                  title: "Restaurant",
                  icon: Icons.restaurant,
                  count: 12,
                  color: Colors.orange,
                ),
                _serviceCard(
                  title: "Pharmacie",
                  icon: Icons.local_pharmacy,
                  count: 6,
                  color: Colors.green,
                ),
                _serviceCard(
                  title: "Supermarché",
                  icon: Icons.shopping_cart,
                  count: 10,
                  color: Colors.purple,
                ),
                _addServiceCard(),
              ],
            ),

            const SizedBox(height: 30),

            /// SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: "Rechercher un pressing...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 20),


            ListView.separated(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: 5, // pressings.length,
  separatorBuilder: (_, __) => const SizedBox(height: 12),
  itemBuilder: (_, index) {
  //  final pressing = pressings[index];

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.local_laundry_service),
        ),
        title: Text(
         "Name", // pressing.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
         "City" // "${pressing.city} • ${pressing.manager}\n"
        "2 Com,mandes" // "${pressing.orders} commandes • "
        "3 employés" // "${pressing.employeeCount} employés",
        ),
        trailing: PopupMenuButton(
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: "details",
              child: Text("Détails"),
            ),
            const PopupMenuItem(
              value: "edit",
              child: Text("Modifier"),
            ),
            const PopupMenuItem(
              value: "delete",
              child: Text("Supprimer"),
            ),
          ],
        ),
      ),
    );
  },
)

/*
            /// TABLE
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DataTable(
                  headingRowHeight: 55,
                  columns: const [
                    DataColumn(label: Text("Pressing")),
                    DataColumn(label: Text("Ville")),
                    DataColumn(label: Text("Manager")),
                    DataColumn(label: Text("Employés")),
                    DataColumn(label: Text("Commandes")),
                    DataColumn(label: Text("Statut")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows: [
                    _row(
                      "Élégance",
                      "Conakry",
                      "Mamadou",
                      "8",
                      "325",
                      true,
                    ),
                    _row(
                      "Premium",
                      "Kankan",
                      "Samba",
                      "5",
                      "182",
                      true,
                    ),
                    _row(
                      "Express Wash",
                      "Labé",
                      "Diallo",
                      "4",
                      "98",
                      false,
                    ),
                  ],
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }

  DataRow _row(
    String name,
    String city,
    String manager,
    String employees,
    String orders,
    bool active,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(city)),
        DataCell(Text(manager)),
        DataCell(Text(employees)),
        DataCell(Text(orders)),
        DataCell(
          Chip(
            label: Text(
              active ? "Actif" : "Inactif",
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _serviceCard({
    required String title,
    required IconData icon,
    required int count,
    required Color color,
  }) {
    return SizedBox(
      width: 220,
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color),
          ),
          title: Text(title),
          subtitle: Text("$count boutiques"),
        ),
      ),
    );
  }

  Widget _addServiceCard() {
    return SizedBox(
      width: 220,
      child: Card(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: const SizedBox(
            height: 80,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline),
                  SizedBox(width: 8),
                  Text("Ajouter un service"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final double _iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
                size: _iconSize,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
  
 