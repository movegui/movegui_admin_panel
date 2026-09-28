import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_page.dart';

class PressingDashboardPage extends DashboardPage {
     const PressingDashboardPage({super.key , required super.models, required super.service});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              title: AppLocalizations.of(context)!.pressing_dashboard_title,
              subtitle: AppLocalizations.of(
                context,
              )!.pressing_dashboard_sub_title,
              buttonText: AppLocalizations.of(context)!.btn_add_pressing,
              onPressed: (item) async {
               context.go(RouteConstants.PRESSING_ADD_ROUTE);
              },
            ),
/*
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "City" // "${pressing.city} • ${pressing.manager}\n"
                      "2 Com,mandes" // "${pressing.orders} commandes • "
                      "3 employés", // "${pressing.employeeCount} employés",
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
            ),

  */
          ],
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
        DataCell(Chip(label: Text(active ? "Actif" : "Inactif"))),
        DataCell(
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.visibility)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            ],
          ),
        ),
      ],
    );
  }



}