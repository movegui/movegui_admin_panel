import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool enabled;
  final String routeName;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    required this.enabled,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: enabled
          ? Icon(icon)
          : Icon(icon, color: AppColors.placeHolderText),
      title: enabled
          ? Text(title, style: const TextStyle(fontWeight: FontWeight.w700))
          : Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.placeHolderText,
              ),
            ),
      trailing: enabled
          ? Icon(Icons.chevron_right)
          : Icon(Icons.chevron_right, color: AppColors.placeHolderText),
      onTap: () {
        enabled
            ? context.go(routeName)
            : MessageWidget.errorMessage(
                context,
                AppLocalizations.of(context)!.deactivate_button_title,
                AppLocalizations.of(context)!.deactivate_button_message,
                Icon(Icons.error, color: AppColors.error),
                FlushbarPosition.TOP,
              );
        
      },
    );
  }
}
