import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/app/main/main_page_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';

class AddModelBtnWidget extends StatelessWidget {
  final MainPageWidget addModelWidget;

  const AddModelBtnWidget({super.key, required this.addModelWidget});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return CustomButon(
      text: loc != null ? AppLocalizations.of(context)!.add : 'Add',
      onTap: () {
        context.go(addModelWidget.buttonItem.routeName!);
      },
      icon: Icons.add,
    );
  }
}
