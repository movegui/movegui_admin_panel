import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget_title.dart';

class PressingIncompleteTabHeader extends StatelessWidget {
  const PressingIncompleteTabHeader({super.key});

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
          text: AppLocalizations.of(context)!.tab_header_name,
          textAlign: TextAlign.left,
        ),

        DisplayWidgetTitle(
          flex: 3,
          text: AppLocalizations.of(context)!.tab_header_problem,
        ),

        DisplayWidgetTitle(
          flex: 1,
          text: AppLocalizations.of(context)!.tab_header_status_title,
        ),
        DisplayWidgetTitle(
          flex: 1,
          text: AppLocalizations.of(context)!.tab_header_actions,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  Widget buildMobile(BuildContext context) {
    return Row(
      children: [
        DisplayWidgetTitle(
          flex: 3,
          text: AppLocalizations.of(context)!.tab_header_name,
          textAlign: TextAlign.left,
        ),

        DisplayWidgetTitle(
          flex: 2,
          text: AppLocalizations.of(context)!.tab_header_problem,
        ),

        DisplayWidgetTitle(
          flex: 2,
          text: AppLocalizations.of(context)!.tab_header_status_title,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
