import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class StatusToggleWidget extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;
  final String? activeDescription;
  final String? deactiveDescription;

  const StatusToggleWidget({
    super.key,
    required this.isActive,
    required this.onChanged,
    this.activeDescription,
    this.deactiveDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: isActive ? AppColors.active : AppColors.disabled,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          isActive
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.service_active_title,
                        style: TextStyle(color: AppColors.active),
                      ),
                      SizedBox(height: 2),
                      Text(
                        activeDescription ?? AppLocalizations.of(context)!.service_active_descrip,
                        style: TextStyle(color: AppColors.info),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       deactiveDescription ?? AppLocalizations.of(context)!.service_deactive_title,
                        style: TextStyle(color: AppColors.disabled),
                      ),
                      SizedBox(height: 2),
                      Text(
                        AppLocalizations.of(context)!.service_deactive_descrip,
                        style: TextStyle(color: AppColors.error),
                      ),
                    ],
                  ),
                ),
          Switch(
            value: isActive,
            onChanged: onChanged,
            activeColor: AppColors.active,
            inactiveThumbColor: AppColors.disabled,
          ),
        ],
      ),
    );
  }
}
