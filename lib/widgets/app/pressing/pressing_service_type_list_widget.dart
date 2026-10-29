import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/pressing_service_type_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_type_widget.dart';

class PressingServiceTypeListWidget extends StatefulWidget {
  final List<PressingServiceTypeFormController> formControllers;
  final Function(int index, bool status) onStatusChanged;

  const PressingServiceTypeListWidget({
    super.key,
    required this.formControllers,
    required this.onStatusChanged,
  });

  @override
  State<StatefulWidget> createState() => PressingServiceTypeListWidgetState();
}

class PressingServiceTypeListWidgetState
    extends State<PressingServiceTypeListWidget> {
  late SeedService seedService;
  final GlobalKey _newServiceKey = GlobalKey();

  @override
  void initState() {
    seedService = getIt<SeedService>();
    super.initState();
  }

  Future<void> addService() async {
    PressingServiceTypeModel? serviceTypeDataTest;

    if (seedService.api.env is EnvDev) {
      serviceTypeDataTest = await seedService.generatePressingTypeModel();
    }

    setState(() {
      widget.formControllers.add(PressingServiceTypeFormController());

      if (serviceTypeDataTest != null) {
        widget.formControllers.last.setData(serviceTypeDataTest);
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

  void onStatusChange(int index, bool status) {
    widget.onStatusChanged.call(index, status);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeader(
          title: AppLocalizations.of(
            context,
          )!.pressing_service_type_add_dashboard_title,
          subtitle: AppLocalizations.of(
            context,
          )!.pressing_service_type_add_dashboard_sub_title,
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
         //     key: controller.formKey,
              child: Center(
                key: index == widget.formControllers.length - 1
                    ? _newServiceKey
                    : null,
                child: PressingServiceTypeWidget(
                  controller: controller,
                  onStatusChange: (bool value) {
                  //  onStatusChange(index, value);
                  controller.isActive =  value;
                  setState(() {
                    
                  });
                  }, onPricingTypeChange: (PricingType? value) { 
                    controller.pricingType = value;
                    setState(() {
                      
                    });
                   },
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
