import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';

class AllModelBtnWidget extends StatelessWidget {
  final Widget allModelWidget;

  const AllModelBtnWidget({super.key, required this.allModelWidget});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return CustomButon(
      text: loc != null ? AppLocalizations.of(context)!.add_all : 'All',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(pageScreen: allModelWidget),
          ),
        );
      },
      icon: Icons.list_alt,
    );
  }
}
