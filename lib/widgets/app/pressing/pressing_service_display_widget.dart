import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_type_form_service.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_type_display_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_list_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/pressing_service_type_picker.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class PressingServiceDisplayWidget extends StatefulWidget {
  const PressingServiceDisplayWidget({
    super.key,
    required this.services,
    required this.title,
    required this.subTitle,
    required this.onRegister,
  });
  final List<PressingServiceModel> services;
  final String title;
  final String subTitle;
  final void Function(List<PressingServiceModel>? services) onRegister;

  @override
  State<PressingServiceDisplayWidget> createState() =>
      PressingServiceDisplayWidgetState();
}

class PressingServiceDisplayWidgetState
    extends State<PressingServiceDisplayWidget> {
  String searchText = '';
  PressingServiceTypeModel? selectedType;

  late List<PressingServiceFormController> formControllers = [];
  late SeedService seedService;
  late PressingServicesFormService servicesFormService;
  late PressingServicesTypeFormService servicesTypeFormService;
  late List<PressingServiceTypeModel> allServiceTypes = [];
  late PressingServiceFormController defaultController;
  final addServicesKey = GlobalKey<PressingServiceListWidgetState>();

  @override
  void initState() {
    super.initState();

    servicesFormService = getIt<PressingServicesFormService>();
    servicesTypeFormService = getIt<PressingServicesTypeFormService>();
    seedService = getIt<SeedService>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadServiceTypes();
    });
  }

  Future<PressingServiceFormController> _addEmptyFormController() async {
    final formController = seedService.api.env is EnvDev
        ? await servicesFormService.getFormController(
            await seedService.getGeneratedPressingService(),
          )
        : PressingServiceFormController();

    formController.serviceType = selectedType?.id != '0999'
        ? selectedType ??
              PressingServiceTypeModel(
                id: '003',
                name: AppLocalizations.of(
                  context,
                )!.pressing_service_dry_cleaning,
                description: AppLocalizations.of(
                  context,
                )!.pressing_service_dry_cleaning_descrip,
                pricingType: PricingType.fixed,
                createdAt: DateTime.now(),
              )
        : PressingServiceTypeModel(
            id: '003',
            name: AppLocalizations.of(context)!.pressing_service_dry_cleaning,
            description: AppLocalizations.of(
              context,
            )!.pressing_service_dry_cleaning_descrip,
            pricingType: PricingType.fixed,
            createdAt: DateTime.now(),
          );
    _trackFormController(formController);
    return formController;
  }

  void _trackFormController(PressingServiceFormController formController) {
    if (!formControllers.contains(formController)) {
      formControllers.add(formController);
    }
  }

  Future<void> _loadServiceTypes() async {
    allServiceTypes.add(
      PressingServiceTypeModel(
        id: '0999',
        name: AppLocalizations.of(context)!.pressing_services_types_all_title,
        description: AppLocalizations.of(
          context,
        )!.pressing_services_types_all_descrip,
        pricingType: PricingType.fixed,
        createdAt: DateTime.now(),
      ),
    );
    allServiceTypes.addAll(
      await AppConstants.getPressingServicesTypes(context),
    );

    if (mounted) {
      setState(() {
        selectedType = allServiceTypes[0];
      });
    }
  }

  List<PressingServiceModel> _servicesForType(PressingServiceTypeModel type) {
    final normalizedSearch = searchText.trim().toLowerCase();

    return widget.services.where((service) {
      final matchesType = service.serviceType.id == type.id;
      final matchesSelectedType =
          selectedType == null ||
          selectedType!.id == '0999' ||
          selectedType!.id == type.id;
      final matchesSearch =
          normalizedSearch.isEmpty ||
          service.name.toLowerCase().contains(normalizedSearch);

      return matchesType && matchesSelectedType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        DashboardHeader(
          title: widget.title,
          subtitle: widget.subTitle,
          onPressed: (item) async {
            final controllers = [await _addEmptyFormController()];
            MyAppFunctions.showMoveguiDialog(
              context,
              PressingServiceListWidget(
                key: addServicesKey,
                formControllers: controllers,
                onFormControllerAdded: (PressingServiceFormController value) {},
                selectedServiceType: selectedType?.id == '0999'
                    ? null
                    : selectedType,
              ),
              Theme.of(context).colorScheme.surface,
              [
                Row(
                  children: [
                    Expanded(child: cancelButton(context)),
                    SizedBox(width: WidgetConstants.sepWidgetWidth * 2),
                    Expanded(child: registerButton(context, controllers)),
                  ],
                ),
              ],
            );
          },
          buttonText: AppLocalizations.of(context)!.btn_create,
          actions: [
            OutlinedButton.icon(
              onPressed: _manageServiceTypes,
              icon: const Icon(Icons.category_outlined),
              label: Text(AppLocalizations.of(context)!.btn_types_services),

              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).primaryColor),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: WidgetConstants.sepWidget),
        _buildFilters(context),
        const SizedBox(height: WidgetConstants.sepWidget),
        _buildServiceTypes(context),
      ],
    );
  }

  Widget registerButton(
    BuildContext dialogContext,
    List<PressingServiceFormController> controllers,
  ) {
    return ButtonWidget(
      onPressed: (item) async {
        if (!validateAllServices(controllers)) return;
        final newServices = await servicesFormService.getModels(controllers);
        if (!mounted) return;
        widget.onRegister.call(newServices);
        setState(() {
          for (final service in newServices) {
            if (!widget.services.contains(service)) {
              widget.services.add(service);
            }
          }
        });
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

  bool validateAllServices(List<PressingServiceFormController> controllers) {
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
        title: AppLocalizations.of(context)!.btn_cancel_label,
        enabled: true,
      ),
      icon: Icon(Icons.cancel),
      textStyle: Theme.of(context).textTheme.displayMedium,
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(
                context,
              )!.pressing_service_search_hinterText,
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: WidgetConstants.sepWidgetWidth),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),

            child: PressingServiceTypePicker(
              service: selectedType,
              servicesTypes: allServiceTypes,
              onServiceTypeChange: (PressingServiceTypeModel? value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceTypes(BuildContext context) {
    final visibleTypes = allServiceTypes.where((type) {
      if (selectedType != null &&
          type.id != selectedType?.id &&
          selectedType?.id != '0999') {
        return false;
      }
      return _servicesForType(type).isNotEmpty;
    }).toList();

    if (visibleTypes.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: visibleTypes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final type = visibleTypes[index];
        final typeServices = _servicesForType(type);

        return PressingServiceTypeDisplayWidget(
          serviceType: type,
          services: typeServices,
          primaryColor: Theme.of(context).primaryColor,
          onAdd: () => _createService(serviceType: type),
          onEdit: _editService,
          onDelete: _deleteService,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final styleText = Responsive.isDesktop(context)
        ? Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20)
        : Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_laundry_service_outlined,
            size: 64,
            color: Theme.of(context).primaryColor.withValues(alpha: .25),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.pressing_service_empty_title,
            style: styleText?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context)!.pressing_service_empty_subtitle,
            style: styleText,
          ),
        ],
      ),
    );
  }

  void _createService({PressingServiceTypeModel? serviceType}) {
    debugPrint('Create service: ${serviceType?.name}');
  }

  void _editService(PressingServiceModel service) {
    debugPrint('Edit: ${service.name}');
  }

  void _deleteService(PressingServiceModel service) {
    debugPrint('Delete: ${service.name}');
  }

  void _manageServiceTypes() {
    debugPrint('Manage service types');
  }
}
