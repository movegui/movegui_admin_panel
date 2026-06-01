import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class StoreOrderWidget extends StatelessWidget {
  const StoreOrderWidget({
    super.key,
    this.backgroundColor = AppColors.backgroundColor,
    this.textColor = AppColors.textColor,
  });
  final Color? backgroundColor;
  final Color? textColor;

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
            color: backgroundColor,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          color: backgroundColor,
          child: ListTile(
            leading:  Icon(Icons.local_laundry_service, color: textColor,),
            title:  Text("Commande #CMD-001", style: TextStyle(color: textColor),),
            subtitle:  Text("3 chemises • 12€", style: TextStyle(color: textColor),),
            trailing: Chip(
              label: const Text("Terminée"),
              backgroundColor: Colors.green.shade100,
            ),
            onTap: () {
              
            },
          ),
        ),

        Card(
          color: backgroundColor,
          child: ListTile(
            leading:  Icon(Icons.local_laundry_service, color: textColor,),
            title:  Text("Commande #CMD-002", style: TextStyle(color: textColor),),
            subtitle:  Text("2 costumes • 20€", style: TextStyle(color: textColor),),
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
