import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class DashboardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? buttonText; 
  final Future<void> Function(ButtonInfo item) onPressed;

  const DashboardHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(WidgetConstants.sepWidget),
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
                title: buttonText ?? AppLocalizations.of(context)!.btn_create,
                enabled: true,
              ),
              icon:Icon(Icons.add),
             textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
