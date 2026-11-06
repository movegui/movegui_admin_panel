import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_order_model.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashbord_cards.dart';

String resolveCustomerDisplayName(Map<String, dynamic>? data, {required String fallback}) {
  if (data == null) return fallback;

  final person = data['person'];
  if (person is Map) {
    final firstName = (person['firstName'] ?? '').toString().trim();
    final lastName = (person['lastName'] ?? '').toString().trim();
    final fullName = [firstName, lastName].where((part) => part.isNotEmpty).join(' ');
    if (fullName.isNotEmpty) {
      return fullName;
    }
  }

  final name = (data['name'] ?? '').toString().trim();
  if (name.isNotEmpty) {
    return name;
  }

  return fallback;
}

class RecentOrderPanel extends StatelessWidget {
  const RecentOrderPanel({super.key, this.orders});
  final List<EstablishmentOrderModel>? orders ;

  @override
  Widget build(BuildContext context) {

if (orders == null || orders!.isEmpty) {
      return const DashBordCards(
        title: 'Dernières commandes',
        icon: Icons.receipt_long,
        child: Center(
          child: Text('Aucune commande récente'),
        ),
      );
    }

    return DashBordCards(
      title: 'Dernières commandes',
      icon: Icons.receipt_long,
      trailing: TextButton(
        onPressed: () {},
        child: const Text('Voir toutes →'),
      ),
      child: Column(
        children: orders!.map((order) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFEEF1F5))),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    order.orderId,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(order.customerId)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Chargement...');
                      }

                      final customerData = snapshot.data?.data();
                      final displayName = resolveCustomerDisplayName(
                        customerData,
                        fallback: order.customerId,
                      );

                      if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
                        return Text(displayName);
                      }

                      return Text(displayName);
                    },
                  ),
                ),
                Expanded(child: Text(order.total.toString())),
                Text(
                  order.status.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}