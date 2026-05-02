import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';

class AddModelBtnWidget extends StatelessWidget {
  final Widget addModelWidget;

  const AddModelBtnWidget({super.key, required this.addModelWidget});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return CustomButon(
      text: loc != null ? AppLocalizations.of(context)!.add : 'Add',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(pageScreen: addModelWidget),
          ),
        );
      },
      icon: Icons.add,
    );
  }
}
