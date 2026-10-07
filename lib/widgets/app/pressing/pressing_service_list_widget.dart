import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_widget.dart';

class PressingServiceListWidget extends StatefulWidget {
  final List<PressingServiceFormController> formControllers;
  final ValueChanged<PressingServiceFormController> onFormControllerAdded;
  final PressingServiceTypeModel? selectedServiceType;
  const PressingServiceListWidget({
    super.key,
    required this.formControllers,
    required this.onFormControllerAdded,
    required this.selectedServiceType,
  });

  @override
  State<StatefulWidget> createState() => PressingServiceListWidgetState();
}

class PressingServiceListWidgetState extends State<PressingServiceListWidget> {
  late SeedService seedService;
  final GlobalKey _newServiceKey = GlobalKey();

  @override
  void initState() {
    seedService = getIt<SeedService>();
    super.initState();
  }

  Future<void> addService() async {
    PressingServiceModel? serviceDataTest;

    if (seedService.api.env is EnvDev) {
      serviceDataTest = await seedService.getGeneratedPressingService();
    }

    setState(() {
      widget.formControllers.add(PressingServiceFormController());
      widget.formControllers.last.serviceType = widget.selectedServiceType ?? PressingServiceTypeModel(
        id: '003',
        name: AppLocalizations.of(context)!.pressing_service_dry_cleaning,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_dry_cleaning_descrip,
        pricingType: PricingType.fixed,
        createdAt: DateTime.now(),
      );

      if (serviceDataTest != null) {
        widget.formControllers.last.setData(serviceDataTest);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToNewestPerson();
    });
  }

  void scrollToNewestPerson() {
    final newServiceContext = _newServiceKey.currentContext;
    if (newServiceContext == null) return;

    Scrollable.ensureVisible(
      newServiceContext,
      alignment: 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  Future<void> onServiceTypeChange(
    int index,
    PressingServiceTypeModel? serviceType,
  ) async {
    setState(() {
      widget.formControllers[index].serviceType = serviceType;
    });
  }

  Future<void> onPricingTypeChange(int index, PricingType? pricingType) async {
    setState(() {
      widget.formControllers[index].serviceType?.pricingType = pricingType;
    });
  }

  Future<void> onStatusChange(int index, bool? status) async {
    setState(() {
      widget.formControllers[index].isActive = status!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeader(
          title: AppLocalizations.of(
            context,
          )!.pressing_service_add_dashboard_title,
          subtitle: AppLocalizations.of(
            context,
          )!.pressing_service_add_dashboard_sub_title,
          onPressed: (item) async {
            await addService();
          },
          buttonText: AppLocalizations.of(context)!.btn_create,
        ),
        SizedBox(height: WidgetConstants.sepWidget),
        ...List.generate(widget.formControllers.length, (index) {
          final controller = widget.formControllers[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Form(
              key: controller.formKey,
              child: Center(
                key: index == widget.formControllers.length - 1
                    ? _newServiceKey
                    : null,
                child: PressingServiceWidget(
                  controller: controller,
                  onServiceTypeChange: (PressingServiceTypeModel? value) async {
                    await onServiceTypeChange.call(index, value);
                  },
                  onPricingTypeChange: (PricingType? value) async {
                    await onPricingTypeChange.call(index, value);
                  },
                  onStatusChange: (bool? value) async {
                    await onStatusChange.call(index, value);
                  },
                  selectedServiceType: widget.selectedServiceType,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
