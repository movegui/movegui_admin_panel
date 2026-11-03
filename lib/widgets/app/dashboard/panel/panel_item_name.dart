import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';

class PanelItemName extends StatelessWidget {
  final ModuleItem moduleItem;

  const PanelItemName({super.key, required this.moduleItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: moduleItem.isActive == true
          ? moduleItem.onTap ?? () async => await notImplemented(context)
          : () async => await notImplemented(context),
      child: Container(
        width: 145,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: moduleItem.color?.withValues(alpha: .07),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              moduleItem.icon,
              color: moduleItem.isActive == true
                  ? moduleItem.color
                  : AppColors.disabled,
            ),
            const SizedBox(height: 8),
            Text(
              moduleItem.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: moduleItem.isActive == true
                    ? moduleItem.color
                    : AppColors.disabled,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> notImplemented(BuildContext context) {
    return MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }
}
