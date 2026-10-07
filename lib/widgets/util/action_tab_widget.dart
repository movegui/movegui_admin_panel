import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';

class ActionTabWidget extends StatelessWidget {
  const ActionTabWidget({super.key, required this.service});
  final PressingServiceModel? service;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Modifier',
          onPressed: () => {}, //_editService(service),
          icon: const Icon(Icons.edit_outlined, size: 19),
    //      color: Theme.of(context).primaryColor,
        ),

        SizedBox(width: WidgetConstants.sepWidget * 0.5,),

        PopupMenuButton<ServiceAction>(
          tooltip: 'Plus d\'actions',
          icon: Icon(Icons.more_vert, size: 20, color: Theme.of(context).colorScheme.onPrimary,),
          onSelected: (action) {
            switch (action) {
              case ServiceAction.edit:
                _editService(service);
                break;

              case ServiceAction.toggleStatus:
                _toggleServiceStatus(service);
                break;

              case ServiceAction.delete:
                _deleteService(service);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: ServiceAction.edit,
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, size: 19),
                  SizedBox(width: 12),
                  Text('Modifier'),
                ],
              ),
            ),

            PopupMenuItem(
              value: ServiceAction.toggleStatus,
              child: Row(
                children: [
                  Icon(
                    (service?.active ?? false)
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 19,
                  ),
                  const SizedBox(width: 12),
                  Text((service?.active ?? false) ? 'Désactiver' : 'Activer'),
                ],
              ),
            ),

            const PopupMenuDivider(),

            const PopupMenuItem(
              value: ServiceAction.delete,
              child: Row(
                children: [
                  Icon(Icons.delete_outline, size: 19, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Supprimer', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _editService(PressingServiceModel? service) {
    debugPrint('Modifier ${service?.name}');
  }

  void _toggleServiceStatus(PressingServiceModel? service) {
    debugPrint(
      '${(service?.isActive ?? false) ? 'Désactiver' : 'Activer'} ${service?.name}',
    );
  }

  void _deleteService(PressingServiceModel? service) {
    debugPrint('Supprimer ${service?.name}');
  }
}

enum ServiceAction { edit, toggleStatus, delete }
