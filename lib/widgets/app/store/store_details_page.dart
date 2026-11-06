import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_page.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_detail_widget.dart';

class StoreDetailsPage<M extends EstablishmentModel> extends DashboardPage {
  final List<ModuleItem> staticsItems;
  final M model;
   final List<UserModel> staff;

  const StoreDetailsPage({
    super.key,
    required this.staticsItems,
    required this.model,
    required super.stats,
    required super.service,
    required this.staff,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeader(
          title: AppLocalizations.of(context)!.pressing_dashboard_title,
          subtitle: AppLocalizations.of(context)!.pressing_dashboard_sub_title,
          buttonText: AppLocalizations.of(context)!.btn_add_pressing,
          onPressed: (item) async {
            context.push(RouteConstants.PRESSING_ADD_ROUTE);
          },
        ),
        SizedBox(height: WidgetConstants.sepWidget),

        Expanded(
          child: StoreDetailWidget<M>(model: model, staticsItems: staticsItems, staff: staff,),
        ),
      ],
    );
  }
}
