import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class DashboardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Future<void> Function(ButtonInfo item) onPressed;

  const DashboardHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            ButtonWidget(
              onPressed: onPressed,
              buttonItem: ButtonInfo(
                title: AppLocalizations.of(context)!.btn_create,
                enabled: true,
              ),
              icon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }
}
