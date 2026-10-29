import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class StatusChip extends StatelessWidget {
  final bool active;

  const StatusChip({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.active : AppColors.disabled;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        active ? '●  ${AppLocalizations.of(context)!.status_actif}' : '●  ${AppLocalizations.of(context)!.status_inactif}',
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}