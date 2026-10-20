import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/model.dart';


class ActionTabWidget<M extends Model> extends StatelessWidget {
  const ActionTabWidget({
    super.key,
    required this.service,
    required this.onEdit,
    required this.onDelete,
    required this.onChangeStatus,
  });
  final M service;
  final ValueChanged<M> onEdit;
  final ValueChanged<M> onDelete;
  final ValueChanged<M> onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: AppLocalizations.of(context)!.tooltip_btn_update,
          onPressed: () {
            onEdit.call(service);
          },
          icon: const Icon(Icons.edit_outlined, size: 19),
        ),

        SizedBox(width: WidgetConstants.sepWidget * 0.5),

        PopupMenuButton<ServiceAction>(
          tooltip: AppLocalizations.of(context)!.tooltip_more_actions,
          icon: Icon(
            Icons.more_vert,
            size: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onSelected: (action) {
            switch (action) {
              case ServiceAction.edit:
                onEdit.call(service);
                break;

              case ServiceAction.toggleStatus:
                onChangeStatus.call(service);
                break;

              case ServiceAction.delete:
                onDelete.call(service);
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: ServiceAction.edit,
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, size: 19),
                  SizedBox(width: 12),
                  Text(AppLocalizations.of(context)!.btn_update),
                ],
              ),
            ),

            PopupMenuItem(
              value: ServiceAction.toggleStatus,
              child: Row(
                children: [
                  Icon(
                    (service.isActive ?? false)
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 19,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    (service.isActive ?? false)
                        ? AppLocalizations.of(context)!.deactif
                        : AppLocalizations.of(context)!.actif,
                  ),
                ],
              ),
            ),

            const PopupMenuDivider(),

            PopupMenuItem(
              value: ServiceAction.delete,
              child: Row(
                children: [
                  Icon(Icons.delete_outline, size: 19, color: Colors.red),
                  SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.btn_delete,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

enum ServiceAction { edit, toggleStatus, delete }
