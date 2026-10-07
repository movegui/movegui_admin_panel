import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class DashboardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? buttonText;
  final Future<void> Function(ButtonInfo item) onPressed;
  final List<Widget>? actions;

  const DashboardHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.buttonText,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(WidgetConstants.sepWidget),
        child: Responsive.isDesktop(context)
            ? _buidDesktop(context)
            : _buildMobile(context),
      ),
    );
  }

  Widget _buidDesktop(BuildContext context) {
    return Row(
      children: [
        Navigator.of(context).canPop()
            ? IconButton(
                tooltip: AppLocalizations.of(context)!.btn_back,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              )
            : SizedBox(),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),

        ...actions ?? [],
        const SizedBox(width: 6),
        ButtonWidget(
          onPressed: onPressed,
          buttonItem: ButtonInfo(
            title: buttonText ?? AppLocalizations.of(context)!.btn_create,
            enabled: true,
          ),
          icon: Icon(Icons.add),
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Navigator.of(context).canPop()
                ? IconButton(
                    tooltip: AppLocalizations.of(context)!.btn_back,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  )
                : SizedBox(),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        /*
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        */
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...actions ?? [],
              const SizedBox(width: 6),
              ButtonWidget(
                onPressed: onPressed,
                buttonItem: ButtonInfo(
                  title: buttonText ?? AppLocalizations.of(context)!.btn_create,
                  enabled: true,
                ),
                icon: const Icon(Icons.add),
                textStyle: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
