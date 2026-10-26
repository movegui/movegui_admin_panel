import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/incomplete_module_configuration_model.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_page.dart';
import 'package:movegui_admin_panel/widgets/app/module_configuration_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/dashboard/pressing_kpi_card.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_incomplete_display_widget.dart';
import 'package:movegui_admin_panel/widgets/section_header_widget.dart';
import 'package:movegui_admin_panel/widgets/util/form_card_widget.dart';

class PressingDashboardPage extends DashboardPage {
  const PressingDashboardPage({
    super.key,
    required super.stats,
    required super.service,
    required this.configurationModules,
    required this.incompletesPressings,
    required this.staticsItems,
  });
  final List<ModuleConfigurationItemModel> configurationModules;
  final List<IncompleteModuleConfigurationModel<PressingModel>>
  incompletesPressings;
  final List<ModuleItem> staticsItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeader(
          title: AppLocalizations.of(context)!.pressing_dashboard_title,
          subtitle: AppLocalizations.of(context)!.pressing_dashboard_sub_title,
          buttonText: AppLocalizations.of(context)!.btn_add_pressing,
          onPressed: (item) async {
            context.go(RouteConstants.PRESSING_ADD_ROUTE);
          },
        ),
        SizedBox(height: WidgetConstants.sepWidget),

        Expanded(
          child: PressingConfigurationPage(
            modules: configurationModules,
            incompletePressings: incompletesPressings,
            staticsItems: staticsItems,
          ),
        ),
      ],
    );
  }
}

class PressingConfigurationPage extends StatelessWidget {
  const PressingConfigurationPage({
    super.key,
    required this.incompletePressings,
    this.onAddPressing,
    this.onManagePressings,
    this.onConfigureServices,
    this.onConfigureOpeningHours,
    this.onConfigureDelivery,
    this.onConfigurePressing,
    required this.modules,
    required this.staticsItems,
  });

  final List<IncompleteModuleConfigurationModel<PressingModel>>
  incompletePressings;
  final List<ModuleConfigurationItemModel> modules;
  final VoidCallback? onAddPressing;
  final VoidCallback? onManagePressings;
  final VoidCallback? onConfigureServices;
  final VoidCallback? onConfigureOpeningHours;
  final VoidCallback? onConfigureDelivery;
  final ValueChanged<IncompleteModuleConfigurationModel<PressingModel>>?
  onConfigurePressing;
  final List<ModuleItem> staticsItems;

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

              FormCardWidget(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: ModuleConfigurationWidget(
                  onManagePressings: onManagePressings,
                  onConfigureServices: onConfigureServices,
                  onConfigureOpeningHours: onConfigureOpeningHours,
                  onConfigureDelivery: onConfigureDelivery,
                  modules: modules,
                ),
              ),

              const SizedBox(height: 16),

              FormCardWidget(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: _buildIcompleteSection(incompletePressings, context),
              ),
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

  Widget _buildIcompleteSection(
    List<IncompleteModuleConfigurationModel<PressingModel>> items,
    BuildContext context,
  ) {
    return Column(
      children: [
        SectionHeaderWidget(
          title: AppLocalizations.of(
            context,
          )!.module_configuration_to_complete_title,
          subtitle: AppLocalizations.of(context)!
              .module_configuration_to_complete_subtitle(
                AppLocalizations.of(context)!.module_pressing_name,
              ),
        ),

        PressingIncompleteDisplayWidget(items: items),
      ],
    );
  }
}

class _EmptyConfigurationState extends StatelessWidget {
  const _EmptyConfigurationState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 28),
      child: Column(
        children: [
          Icon(Icons.task_alt_rounded, color: Color(0xFF16A34A), size: 44),
          SizedBox(height: 10),
          Text(
            'Toutes les configurations sont complètes',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF172554),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
