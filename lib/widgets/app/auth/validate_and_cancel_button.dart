import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class ValidateAndCancelButton extends StatelessWidget {
  final Future<void> Function(ButtonInfo item) onValidate;
  final Future<void> Function(ButtonInfo item) onCancel;

  const ValidateAndCancelButton({super.key, required this.onValidate, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ButtonWidget(
              onPressed: onCancel,
              buttonItem: ButtonInfo(title: AppLocalizations.of(context)!.btn_cancel_label, enabled: true,),
              textStyle: Responsive.isMobile(context)
                  ? Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary)
                  : Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ButtonWidget(
              onPressed: onValidate,
              buttonItem: ButtonInfo(title: AppLocalizations.of(context)!.btn_register_label, enabled: true,),
              textStyle: Responsive.isMobile(context)
                  ? Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary)
                  :  Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
