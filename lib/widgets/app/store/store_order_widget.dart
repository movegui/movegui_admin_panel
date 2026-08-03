import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class StoreOrderWidget extends StatelessWidget {
  const StoreOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.last_orders,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          child: ListTile(
            leading:  Icon(Icons.local_laundry_service,),
            title:  Text("Commande #CMD-001", ),
            subtitle:  Text("3 chemises • 12€", ),
            trailing: Chip(
              label: const Text("Terminée"),
              backgroundColor: Colors.green.shade100,
            ),
            onTap: () {
              
            },
          ),
        ),

        Card(
          child: ListTile(
            leading:  Icon(Icons.local_laundry_service, ),
            title:  Text("Commande #CMD-002",),
            subtitle:  Text("2 costumes • 20€",),
            trailing: Chip(
              label: const Text("En cours"),
              backgroundColor: Colors.orange.shade100,
            ),
            onTap: () {
              
            },
          ),
        ),
      ],
    );
  }
}
