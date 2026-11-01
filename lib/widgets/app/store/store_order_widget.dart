import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/util/section_container_widget.dart';
import 'package:movegui_admin_panel/widgets/util/section_title_widget.dart';

class StoreOrderWidget extends StatelessWidget {
  const StoreOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitleWidget(
            title: AppLocalizations.of(context)!.last_orders,
            subtitle: AppLocalizations.of(context)!.last_orders_subtitle,
          ),
      
          const SizedBox(height: WidgetConstants.sepWidget),
      
          Card(
            child: ListTile(
              leading: Icon(Icons.local_laundry_service),
              title: Text("Commande #CMD-001"),
              subtitle: Text("3 chemises • 12€"),
              trailing: Chip(
                label: const Text("Terminée"),
                backgroundColor: Colors.green.shade100,
              ),
              onTap: () {},
            ),
          ),
      
          Card(
            child: ListTile(
              leading: Icon(Icons.local_laundry_service),
              title: Text("Commande #CMD-002"),
              subtitle: Text("2 costumes • 20€"),
              trailing: Chip(
                label: const Text("En cours"),
                backgroundColor: Colors.orange.shade100,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
