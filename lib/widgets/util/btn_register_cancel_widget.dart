import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/widgets/app/auth/validation_button.dart';

class BtnRegisterCancelWidget extends StatelessWidget {
  final Future<void> Function(ButtonInfo item) actionFCT;
  final Future<void> Function(ButtonInfo item) cancelFCT;
  final String? actionTitle;
  final Widget? icon;
  final String? actionRouteName;
  final String? cancelRouteName;
  final bool? actionEnabled;

  const BtnRegisterCancelWidget({
    super.key,
    required this.actionFCT,
    required this.cancelFCT,
    this.actionTitle,
    this.icon,
    this.actionRouteName = '',
    this.cancelRouteName = '',
    this.actionEnabled = true,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValidationButton(
            fn: actionFCT,
            buttonItem: ButtonInfo(
              title:
                  actionTitle ??
                  AppLocalizations.of(context)!.btn_register_label,
              enabled: actionEnabled ?? true,
              routeName: actionRouteName ?? '',
            ),
            icon: icon ?? Icon(Icons.save),
          ),
        ),
        SizedBox(width: WidgetConstants.sepWidgetHeight),
        Expanded(
          child: ValidationButton(
            fn: cancelFCT,
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.btn_cancel_label,
              enabled: true,
              routeName: '',
            ),
            icon: Icon(Icons.cancel_outlined),
          ),
        ),
      ],
    );
  }
}
