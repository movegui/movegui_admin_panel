import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class DashboardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onCreatePressed;

  const DashboardHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //   color: AppColors.moveGuiRed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium, //.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: onCreatePressed,
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.btn_create),
              style: ElevatedButton.styleFrom(
                //     backgroundColor: AppColors.moveGuiRed,
                //    foregroundColor: AppColors.cardBg,
                elevation: 3,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
