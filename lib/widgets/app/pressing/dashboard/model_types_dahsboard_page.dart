import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/models/types_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_type_form_service.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/pressing_service_type_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_page.dart';
import 'package:movegui_admin_panel/widgets/app/module_configuration_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/dashboard/pressing_kpi_card.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_type_list_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/model_picker.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';
import 'package:movegui_admin_panel/widgets/util/form_card_widget.dart';
import 'package:movegui_admin_panel/widgets/util/search_filter_row.dart';

class ModelTypesDahsboardPage<M extends TypesModel> extends DashboardPage {
  const ModelTypesDahsboardPage({
    super.key,
    required super.stats,
    required super.service,
    required this.staticsItems,
    required this.modules,
    required this.types,
    required this.selectedType,
    required this.onTypeChange,
    required this.onSearchChanged,
    required this.onEdit,
    required this.onDelete,
    required this.onChangeStatus,
    required this.onRegister,
  });
  final List<ModuleItem> staticsItems;
  final List<ModuleConfigurationItemModel<M>> modules;
  final List<M> types;
  final M selectedType;
  final ValueChanged<M?> onTypeChange;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ModuleConfigurationItemModel<M>>? onEdit;
  final ValueChanged<ModuleConfigurationItemModel<M>>? onDelete;
  final ValueChanged<ModuleConfigurationItemModel<M>>? onChangeStatus;
  final ValueChanged<List<PressingServiceTypeFormController>> onRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeader(
          title: AppLocalizations.of(context)!.pressing_services_types_title,
          subtitle: AppLocalizations.of(
            context,
          )!.pressing_services_types_subtitle,
          buttonText: AppLocalizations.of(context)!.btn_create,
          onPressed: (item) async {
            final seedService = getIt<SeedService>();
            final formController = PressingServiceTypeFormController();
            PressingServiceTypeModel? serviceTypeDataTest;

            if (seedService.api.env is EnvDev) {
              serviceTypeDataTest = await seedService
                  .generatePressingTypeModel();
              formController.setData(serviceTypeDataTest);
            }
            showPressingServicTypeeWidget(
              controllers: [formController],
              dialogContext: context,
            );
          },
        ),
        SizedBox(height: WidgetConstants.sepWidget),

        Expanded(
          child: TypesConfigurationPage<M>(
            staticsItems: staticsItems,
            modules: modules,
            types: types,
            stats: stats,
            service: service,
            selectedType: selectedType,
            onServiceTypeChange: onTypeChange,
            onSearchChanged: onSearchChanged,
            onEdit: (value) async {
              final pressingServicesTypeFormService =
                  getIt<PressingServicesTypeFormService>();
              final formController = await pressingServicesTypeFormService
                  .getFormController(
                    value.item.model! as PressingServiceTypeModel,
                  );
              showPressingServicTypeeWidget(
                controllers: [formController],
                dialogContext: context,
              );
            },
            onDelete: (value) {
              MessageWidget.errorMessage(
                context,
                AppLocalizations.of(context)!.deactivate_button_title,
                AppLocalizations.of(context)!.deactivate_button_message,
                Icon(Icons.error, color: AppColors.error),
                FlushbarPosition.TOP,
              );
            },
            onChangeStatus: onChangeStatus,
          ),
        ),
      ],
    );
  }

  Future<void> showPressingServicTypeeWidget({
    required List<PressingServiceTypeFormController> controllers,
    PressingServiceTypeModel? type,
    required BuildContext dialogContext,
  }) async {
    MyAppFunctions.showMoveguiDialog(
      dialogContext,
      PressingServiceTypeListWidget(
        //  key: addServicesKey,
        formControllers: controllers,
        onStatusChanged: (index, status) {
          controllers[index].isActive = status;
        },
      ),
      Theme.of(dialogContext).colorScheme.surface,
      [
        Row(
          children: [
            Expanded(child: cancelButton(dialogContext)),
            SizedBox(width: WidgetConstants.sepWidgetWidth * 2),
            Expanded(
              child: registerButton(
                dialogContext: dialogContext,
                controllers: controllers,
                onRegister: (values) {
                  onRegister.call(values);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget registerButton({
    required BuildContext dialogContext,
    required List<PressingServiceTypeFormController> controllers,
    required ValueChanged<List<PressingServiceTypeFormController>> onRegister,
  }) {
    return ButtonWidget(
      onPressed: (item) async {
        if (!validateAllServices(controllers)) return;
        onRegister.call(controllers);
        dialogContext.pop();
      },
      buttonItem: ButtonInfo(
        title: AppLocalizations.of(dialogContext)!.btn_register_label,
        enabled: true,
      ),
      icon: Icon(Icons.save),
      textStyle: Theme.of(dialogContext).textTheme.displayMedium,
    );
  }

  bool validateAllServices(
    List<PressingServiceTypeFormController> controllers,
  ) {
    var allValid = true;
    for (final controller in controllers) {
      if (!controller.isValid()) {
        allValid = false;
      }
    }
    return allValid;
  }

  Widget cancelButton(BuildContext dialogContext) {
    return ButtonWidget(
      onPressed: (item) async {
        dialogContext.pop();
      },
      buttonItem: ButtonInfo(
        title: AppLocalizations.of(dialogContext)!.btn_cancel_label,
        enabled: true,
      ),
      icon: Icon(Icons.cancel),
      textStyle: Theme.of(dialogContext).textTheme.displayMedium,
    );
  }
}

class TypesConfigurationPage<M extends TypesModel> extends StatelessWidget {
  const TypesConfigurationPage({
    super.key,
    this.selectedTypes,
    required this.staticsItems,
    required this.modules,
    required this.types,
    required this.stats,
    required this.service,
    required this.selectedType,
    required this.onServiceTypeChange,
    required this.onSearchChanged,
    required this.onEdit,
    required this.onDelete,
    required this.onChangeStatus,
  });

  final List<PressingServiceTypeModel>? selectedTypes;
  final List<ModuleItem> staticsItems;
  final List<ModuleConfigurationItemModel<M>> modules;
  final List<M> types;
  final DashboardModelData stats;
  final DashboardService service;
  final M? selectedType;
  final ValueChanged<M?> onServiceTypeChange;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ModuleConfigurationItemModel<M>>? onEdit;
  final ValueChanged<ModuleConfigurationItemModel<M>>? onDelete;
  final ValueChanged<ModuleConfigurationItemModel<M>>? onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double padding = Responsive.isMobile(context) ? 2 : 3;
        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatisticsSection(staticsItems),
              const SizedBox(height: WidgetConstants.sepWidget),
              _buildFilters(context),
              const SizedBox(height: WidgetConstants.sepWidget),

              FormCardWidget(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                child: ModuleConfigurationWidget(
                  modules: modules,
                  withAction: true,
                  onEdit: onEdit,
                  onDelete: onDelete,
                  onChangeStatus: onChangeStatus,
                ),
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

  Widget _buildFilters(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchFilterRow(
        hintText: AppLocalizations.of(
          context,
        )!.pressing_service_search_hinterText,
        onSearchChanged: onSearchChanged,
        filter: ModelPicker<M>(
          selectedModel: selectedType,
          onSelectedModelChange: onServiceTypeChange,
          models: types,
        ),
      ),
    );
  }
}
