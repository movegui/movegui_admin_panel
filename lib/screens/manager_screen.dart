import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/app/main/main_page_widget.dart';

class ManagerScreen extends ConsumerWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  ManagerPage(
        addModelWidget: MainPageWidget(
    //      widget: AddEmployeWidget(),
          buttonItem: ButtonInfo(
            title: AppLocalizations.of(context)!.add,
            enabled: true,
            routeName: RouteConstants.MANAGER_ADD_ROUTE, 
/*
            onPress: () {  
               ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.manager_add_bar_title);
               context.go(RouteConstants.MANAGER_ADD_ROUTE);
            },
            */
          ),
        ),
        allModelWidget: MainPageWidget(
          buttonItem: ButtonInfo(
            title: AppLocalizations.of(context)!.add_all,
            enabled: true,
            routeName: RouteConstants.MANAGER_ALL_ROUTE,
            /*
             onPress: ()  async { 
             ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.manager_all_bar_title);
              context.go(RouteConstants.MANAGER_ALL_ROUTE); },
              */
          ),
        ),
      
    );
  }
}

class ManagerPage extends MainPage {
  const ManagerPage({
    super.key,
    required super.addModelWidget,
    required super.allModelWidget,
  });
}
