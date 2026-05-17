import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/app/admin/add_admin_widget.dart';
import 'package:movegui_admin_panel/widgets/app/admin/all_admin_widget.dart';
import 'package:movegui_admin_panel/widgets/app/main/main_page_widget.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminPage(
      addModelWidget: MainPageWidget(
        //       widget: AddAdminWidget(),
        buttonItem: ButtonItem(
          AppLocalizations.of(context)!.add,
          tooltipText: AppLocalizations.of(context)!.tooltip_add,
          enabled: true,
          routeName: RouteConstants.ADMIN_ADD_ROUTE,
          onPress: () {
            ref
                .read(AppbarTitleProvider.appbarTitleProvider)
                .setTitle(AppLocalizations.of(context)!.admin_add_bar_title);
            context.go(RouteConstants.ADMIN_ADD_ROUTE);
          },
        ),
      ),
      allModelWidget: MainPageWidget(
        //        widget: AllAdminWidget(),
        buttonItem: ButtonItem(
          AppLocalizations.of(context)!.add_all,
          tooltipText: AppLocalizations.of(context)!.tooltip_all,
          enabled: true,
          routeName: RouteConstants.ADMIN_ALL_ROUTE,
          onPress: () async {
            ref
                .read(AppbarTitleProvider.appbarTitleProvider)
                .setTitle(AppLocalizations.of(context)!.admin_all_bar_title);
            context.go(RouteConstants.ADMIN_ALL_ROUTE);
          },
        ),
      ),
    );
  }
}

class AdminPage extends MainPage {
  const AdminPage({
    super.key,
    required super.addModelWidget,
    required super.allModelWidget,
  });
}
