import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget_title.dart';

class UserTabHeaderWidget extends StatelessWidget {
  const UserTabHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Responsive.isDesktop(context)
          ? buildDesktop(context)
          : buildMobile(context),
    );
  }

  Widget buildDesktop(BuildContext context) {
    return Row(
      children: [
        DisplayWidgetTitle(
          flex: 3,
          text: AppLocalizations.of(context)!.label_name,
          textAlign: TextAlign.left,
        ),

        DisplayWidgetTitle(
          flex: 3,
          text: AppLocalizations.of(context)!.label_email,
        ),

        DisplayWidgetTitle(
          flex: 2,
          text: AppLocalizations.of(context)!.label_phone,
        ),

        DisplayWidgetTitle(
          flex: 2,
          text: AppLocalizations.of(context)!.label_role,
          //      textAlign: TextAlign.end,
        ),

        DisplayWidgetTitle(
          flex: 2,
          text: AppLocalizations.of(context)!.tab_header_status_title,
          //      textAlign: TextAlign.end,
        ),
        DisplayWidgetTitle(flex: 2, text: 'Actions', textAlign: TextAlign.end),
      ],
    );
  }

  Widget buildMobile(BuildContext context) {
    return Row(
      children: [
        DisplayWidgetTitle(
          flex: 2,
          text: AppLocalizations.of(context)!.label_firstname,
          textAlign: TextAlign.left,
        ),

        DisplayWidgetTitle(
          flex: 3,
          text: AppLocalizations.of(context)!.label_email,
        ),

        DisplayWidgetTitle(
          flex: 2,
          text: AppLocalizations.of(context)!.label_phone,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
