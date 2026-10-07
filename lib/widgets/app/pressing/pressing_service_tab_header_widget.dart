import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget_title.dart';

class PressingServiceTabHeaderWidget extends StatelessWidget {
  const PressingServiceTabHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Responsive.isDesktop(context) ? buildDesktop(context) : buildMobile(context)
    );
  }

  Widget buildDesktop(BuildContext context) {
    return  Row(
        children: [
          DisplayWidgetTitle(
            flex: 4,
            text: AppLocalizations.of(
              context,
            )!.pressing_service_header_tab_produit_title,
            textAlign: TextAlign.left,
          ),

          DisplayWidgetTitle(
            flex: 2,
            text: AppLocalizations.of(
              context,
            )!.pressing_service_header_tab_price_title,
          ),

          DisplayWidgetTitle(
            flex: 2,
            text: AppLocalizations.of(
              context,
            )!.pressing_service_header_tab_invoicing_title,
          ),

          DisplayWidgetTitle(
            flex: 2,
            text: AppLocalizations.of(
              context,
            )!.pressing_service_header_tab_duration_title,
          ),

          DisplayWidgetTitle(
            flex: 2,
            text: AppLocalizations.of(
              context,
            )!.pressing_service_header_tab_status_title,
      //      textAlign: TextAlign.end,
          ),
                    DisplayWidgetTitle(
            flex: 2,
            text: 'Actions',
            textAlign: TextAlign.end,
          ),
        ],
      );
  }

  Widget buildMobile(BuildContext context){
  return   Row(
        children: [
          DisplayWidgetTitle(
            flex: 3,
            text: AppLocalizations.of(
              context,
            )!.pressing_service_header_tab_produit_title,
            textAlign: TextAlign.left,
          ),

          DisplayWidgetTitle(
            flex: 2,
            text: AppLocalizations.of(
              context,
            )!.pressing_service_header_tab_price_title,
          ),


          DisplayWidgetTitle(
            flex: 2,
            text: AppLocalizations.of(
              context,
            )!.pressing_service_header_tab_status_title,
            textAlign: TextAlign.end,
          ),
        ],
      );
  }
}
