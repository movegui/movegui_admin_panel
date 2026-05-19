import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/app/main/main_page_widget.dart';


class PressingScreen extends ConsumerWidget {
  const PressingScreen({super.key,});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
        return  PressingPage(
        addModelWidget: MainPageWidget(
          buttonItem: ButtonItem(
            AppLocalizations.of(context)!.add,
            tooltipText: AppLocalizations.of(context)!.tooltip_add,
            enabled: true,
            routeName: RouteConstants.PRESSING_ADD_ROUTE, onPress: () {  
               ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.pressing_add_bar_title);
               context.go(RouteConstants.PRESSING_ADD_ROUTE);
            },
          ),
        ),
        allModelWidget: MainPageWidget(
          buttonItem: ButtonItem(
            AppLocalizations.of(context)!.add_all,
            tooltipText: AppLocalizations.of(context)!.tooltip_all,
            enabled: true,
            routeName: RouteConstants.PRESSING_ALL_ROUTE, onPress: ()  async { 
             ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.pressing_all_bar_title);
              context.go(RouteConstants.PRESSING_ALL_ROUTE); },
          ),
        ),
      
    );
  }
}

class PressingPage extends MainPage {
  const PressingPage({
    super.key,
    required super.addModelWidget,
    required super.allModelWidget,
  });
}
