import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';


class AuthLinkWidget extends StatefulWidget {
  final String? email;

  const AuthLinkWidget({super.key, this.email});
  @override
  State<StatefulWidget> createState() => AuthLinkWidgetState();
}

class AuthLinkWidgetState extends State<AuthLinkWidget> {
  void _onPressed(BuildContext context, ButtonItem item) {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      context.go(item.routeName!, extra: {widget.email});
      /*
      Navigator.pushNamed(
        context,
        item.routeName!,
        arguments: {'item': item, 'email': widget.email},
      );
      */
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ButtonWidget(
              onPressed: (context, buttomItem) async {
                _onPressed(context, buttomItem);
              },
              buttonItem: ButtonItem(
                AppLocalizations.of(context)!.label_login_forget_password,
                AppLocalizations.of(context)!.tooltip_forget_password,
                true,
                routeName: RouteConstants.FORGET_PASSWORD_ROUTE,
              ),
              icon: Ionicons.key_outline,
              fontSize: Responsive.isMobile(context) ? WidgetConstants.buttonFonsize * 1.4 : WidgetConstants.buttonFonsize * 2,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: WidgetConstants.sepWidgetHeight, right: WidgetConstants.sepWidgetHeight,),
            child: ButtonWidget(
              onPressed: (context, buttomItem) async {
                _onPressed(context, buttomItem);
              },
              buttonItem: ButtonItem(
                AppLocalizations.of(context)!.label_registration,
                AppLocalizations.of(context)!.tooltip_registration,
                true,
                routeName: RouteConstants.REGISTER_ROUTE,
              ),
              icon: Ionicons.person,
              fontSize: Responsive.isMobile(context) ? WidgetConstants.buttonFonsize * 1.4 : WidgetConstants.buttonFonsize * 2,
            ),
          ),
        ),
      ],
    );
  }
}
