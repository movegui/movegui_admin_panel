import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/dashboard/pressing_kpi_card.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_employe_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_info_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_order_widget.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';
import 'package:movegui_admin_panel/widgets/util/form_card_widget.dart';
import 'package:movegui_admin_panel/widgets/util/layout_buider_widget.dart';

class StoreDetailWidget<M extends EstablishmentModel> extends StatelessWidget {
  final List<ModuleItem> staticsItems;
  final M model;
  final List<UserModel> staff;

  const StoreDetailWidget({
    super.key,
    required this.staticsItems,
    required this.model,
    required this.staff
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double padding = Responsive.isMobile(context) ? 12 : 20;
        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatisticsSection(staticsItems),
              const SizedBox(height: 16),
              _buildInformationCard(context),
              const SizedBox(height: 16),
              const StoreOrderWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatisticsSection(List<ModuleItem> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        int columns;
        Responsive.isDesktop(context) ? columns = 5 : columns = 1;
        final width =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: PressingKpiCard(item: item),
              ),
          ],
        );
      },
    );
  }

  Widget _buildInformationCard(BuildContext context) {
    return LayoutBuilderWidget(
      children: [
        FormCardWidget(
          child: StoreInfoWidget(
            model: model,
            options: [
              ButtonWidget(
                onPressed: (item) async {
                  context.push(
                    '${RouteConstants.PRESSING_EDIT_ROUTE}/${model.id}',
                  );
                },
                buttonItem: ButtonInfo(
                  title: AppLocalizations.of(context)!.btn_update,
                  enabled: true,
                ),
              ),
            ],
          ),
        ),

        /// EMPLOYEES
        FormCardWidget(
          child: StoreEmployeWidget(
            employees: staff,
            options: [
              ButtonWidget(
                onPressed: (item) async {
                  context.push(
                    '${RouteConstants.PRESSING_EDIT_ROUTE}/${model.id}',
                  );
                },
                buttonItem: ButtonInfo(
                  title: AppLocalizations.of(context)!.btn_update,
                  enabled: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
