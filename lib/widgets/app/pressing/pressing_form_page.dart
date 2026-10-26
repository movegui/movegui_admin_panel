import 'dart:core';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/responsive_grid.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_form_service.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/pressing_form_controller.dart';
import 'package:movegui_admin_panel/util/pressing_submit_handler.dart';
import 'package:movegui_admin_panel/widgets/app/auth/validate_and_cancel_button.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/order_status_panel.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_display_widget.dart';
import 'package:movegui_admin_panel/widgets/app/service_card.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_open_hours_display_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_widget.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/kpi_card.dart';
import 'package:movegui_admin_panel/widgets/app/users/user_display_widget.dart';

class PressingFormPage extends StatefulWidget {
  const PressingFormPage({super.key, this.pressingId});
  final String collectionName = 'pressings';
  final String? pressingId;
  bool get isEditing => pressingId != null;

  @override
  State<StatefulWidget> createState() => PressingFormPageState();
}

class PressingFormPageState extends State<PressingFormPage> {
  final formController = PressingFormController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late PressingService pressingService;
  late PressingFormService formService;
  late SeedService seedService;
  late UserService userService;
  late final DashboardService dashboardService;
  DashboardModelData stats = DashboardModelData.empty();
  bool _isLoadingDashboard = false;
  late PressingModel pressingModel;

  @override
  void initState() {
    super.initState();
    pressingService = getIt<PressingService>();
    formService = getIt<PressingFormService>();
    seedService = getIt<SeedService>();
    userService = getIt<UserService>();
    dashboardService = getIt<DashboardService>();
    initDashboardItems();
    if (widget.isEditing) {
      initEditMode();
    } else {
      loadDatatest();
    }
  }

  /*
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isLoadingDashboard) {
      return;
    }
    _isLoadingDashboard = true;
    await loadDatatest();
    _isLoadingDashboard = false;
  }
  */

  Future<void> initEditMode() async {
    final pressingId = widget.pressingId;
    if (pressingId != null) {
      pressingModel = await pressingService.getModelById(pressingId);
      final services = await pressingService.getAllServices(pressingId);
      formController.services?.addAll(services);
      await formController.setData(pressingModel);
      formController.editMode = true;
      setState(() {});
    }
  }

  Future<void> initDashboardItems() async {
    final items = await dashboardService.loadDashboardItems(
      FirebaseFirestore.instance,
    );

    setState(() {
      stats = items;
    });
  }

  Future<void> loadDatatest() async {
    if (seedService.api.env is EnvDev && !widget.isEditing) {
      final service = await seedService.getGeneratedPressingService();

      final pressingTestData = await seedService.generatePressing();

      if (!mounted) {
        return;
      }
      formController.services?.add(service);
      await formController.setData(pressingTestData);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (!Responsive.isDesktop(context)) {
              return _buidContent();
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buidContent()),
                SizedBox(
                  width: 340,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 24, 24, 24),
                    child: Column(
                      children: [
                        itemsWidget(stats, dashboardService),
                        const SizedBox(height: 16),
                        OrderStatusPanel(stats: stats),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void updateOwnerCount(int value) {
    setState(() {});
  }

  void updateemployeCount(int value) {
    setState(() {});
  }

  void updateManagerCount(int value) {
    setState(() {});
  }

  void updateServicesCount(int value) {
    setState(() {});
  }

  late final submitHandler = PressingSubmitHandler(
    service: pressingService,
    imageService: ImageService(),
    collectionName: widget.collectionName,
    formService: formService,
    userService: userService,
    context: context,
  );

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!formKey.currentState!.validate() ||
        !formController.hasImage ||
        formController.staff!.isEmpty ||
        formController.services!.isEmpty ||
        formController.weeklyHours.isEmpty) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_title,
        AppLocalizations.of(context)!.error_register_with_phone_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      final isCompleted = formController.isPressingCompleted;
      formController.isCompleted = isCompleted;

      await submitHandler.submit(form: formController);
      if (!mounted) return;
      if (!formController.editMode) {
        showAlertBar(
          context,
          AppLocalizations.of(context)!.store_add_success_message(
            AppLocalizations.of(context)!.module_pressing_name,
          ),
        );
      } else {
        showAlertBar(
          context,
          AppLocalizations.of(context)!.store_edit_success_message(
            AppLocalizations.of(context)!.module_pressing_name,
          ),
        );
      }

      context.go(RouteConstants.PRESSING_ROUTE);
    } catch (e) {
      try {
        final pressing = await pressingService.getModelById(formController.id!);
        pressing.isActive = false;
        pressing.isComplete = false;
        await pressingService.addModel(pressing);
      } catch (e) {
        if (!mounted) return;

        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_register_title,
          AppLocalizations.of(context)!.error_register_with_phone_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
        setState(() => isLoading = false);
        return;
      }
      if (!mounted) return;

      showBtmAlert(context, e.toString());
    }

    if (mounted) setState(() => isLoading = false);
  }

  Future<void> pickAnImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          formController.pickedImage = selected;
        });
      } else {
        showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          formController.webImage = f;
          formController.pickedImage = File('a');
        });
      } else {
        showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
      }
    } else {
      showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
    }
  }

  Widget _buidContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DashboardHeader(
                  title: AppLocalizations.of(
                    context,
                  )!.pressing_add_dashboard_title,
                  subtitle: AppLocalizations.of(
                    context,
                  )!.pressing_add_dashboard_sub_title,
                  onPressed: (item) async {
                    context.go(RouteConstants.PRESSING_ALL_ROUTE);
                  },
                  buttonText: AppLocalizations.of(context)!.btn_all_cleaners,
                ),

                const SizedBox(height: WidgetConstants.sepWidget),
                StoreWidget(
                  storeConstants: PressingConstants(),
                  formController: formController,
                  onPickImage: pickAnImage,
                  onRemoveImage: () {
                    setState(() {
                      formController.pickedImage = null;
                      formController.webImage = Uint8List(8);
                    });
                  },
                  onAdressTypeChange: (String? value) {
                    setState(() {
                      formController.addressForm.selectedType = value!;
                    });
                  },
                  onCommuneChange: (String? value) {
                    setState(() {
                      formController.addressForm.selectedMunicipality = value!;
                    });
                  },
                  //    textColor: AppColors.textColor,
                  onHoursChanged: (List<OpenHoursModel> hours) {
                    setState(() {
                      formController.weeklyHours = hours;
                    });
                  },
                  onStatusChanged: (bool value) {
                    setState(() {
                      formController.isActive = value;
                    });
                  },
                ),

                const SizedBox(height: WidgetConstants.sepWidget),
                _buildServiceCard(
                  context,
                  formController.staff ?? [],
                  formController.services ?? [],
                ),
                const SizedBox(height: WidgetConstants.sepWidget),
                ValidateAndCancelButton(
                  onValidate: (ButtonInfo item) async {
                    await _onSubmit();
                  },
                  onCancel: (ButtonInfo item) async {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
          //    ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    List<UserModel> users,
    List<PressingServiceModel> servicesModels,
  ) {
    final owners = users.where((elem) => elem.role == UserRole.Owner).toList();
    final managers = users
        .where((elem) => elem.role == UserRole.Manager)
        .toList();
    final employees = users
        .where((elem) => elem.role == UserRole.Employe)
        .toList();
    final openDays = formController.weeklyHours
        .where((hour) => hour.isOpen == true)
        .length;
    final openTxt = AppLocalizations.of(context)!.store_open;
    final daysTxt = AppLocalizations.of(context)!.days;

    return Wrap(
      spacing: 3,
      runSpacing: 3,
      children: [
        ServiceCard(
          title: AppLocalizations.of(context)!.module_owner_name,
          icon: Icons.admin_panel_settings,
          count: owners.length,
          color: Colors.blue,
          onPress: () => MyAppFunctions.showMoveguiDialog(
            context,
            UserDisplayWidget(
              users: owners,
              title: AppLocalizations.of(context)!.owner_add_dashboard_title,
              subTitle: AppLocalizations.of(
                context,
              )!.owner_add_dashboard_sub_title,
              onRegister: (List<UserModel>? newOwners) {
                setState(() {
                  users.addAll(newOwners ?? []);
                });
                context.pop();
              },
              onDelete: (int index) {
                setState(() {
                  users.removeAt(index);
                });
              },
              onChangeStatus: (int index) {
                setState(() {
                  users[index].isActive = !(users[index].isActive ?? true);
                });
              },
            ),
            Theme.of(context).colorScheme.surface,
            [],
          ),
        ),
        ServiceCard(
          title: AppLocalizations.of(context)!.module_manager_name,
          icon: Icons.supervisor_account,
          count: managers.length,
          color: Colors.purple,
          onPress: () => MyAppFunctions.showMoveguiDialog(
            context,
            UserDisplayWidget(
              users: managers,
              title: AppLocalizations.of(context)!.manager_add_dashboard_title,
              subTitle: AppLocalizations.of(
                context,
              )!.manager_add_dashboard_sub_title,
              onRegister: (List<UserModel>? newManagers) {
                setState(() {
                  users.addAll(newManagers ?? []);
                });
              },
              onDelete: (int index) {
                setState(() {
                  users.removeAt(index);
                });
              },
              onChangeStatus: (int index) {
                setState(() {
                  users[index].isActive = !(users[index].isActive ?? true);
                });
              },
            ),
            Theme.of(context).colorScheme.surface,
            [],
          ),
        ),
        ServiceCard(
          title: AppLocalizations.of(context)!.module_employe_name,
          icon: Icons.badge,
          count: employees.length,
          color: Colors.green,
          onPress: () => MyAppFunctions.showMoveguiDialog(
            context,
            UserDisplayWidget(
              users: employees,
              title: AppLocalizations.of(context)!.employe_add_dashboard_title,
              subTitle: AppLocalizations.of(
                context,
              )!.employe_add_dashboard_sub_title,
              onRegister: (List<UserModel>? newEmployees) {
                setState(() {
                  users.addAll(newEmployees ?? []);
                });
              },
              onDelete: (int index) {
                setState(() {
                  users.removeAt(index);
                });
              },
              onChangeStatus: (int index) {
                setState(() {
                  users[index].isActive = !(users[index].isActive ?? true);
                });
              },
            ),
            Theme.of(context).colorScheme.surface,
            [],
          ),
        ),
        ServiceCard(
          title: AppLocalizations.of(context)!.module_services_name,
          icon: Icons.room_service,
          count: servicesModels.length,
          color: Colors.orange,
          onPress: () => MyAppFunctions.showMoveguiDialog(
            context,
            PressingServiceDisplayWidget(
              services: servicesModels,
              title: AppLocalizations.of(
                context,
              )!.pressing_services_dashboard_title,
              subTitle: AppLocalizations.of(
                context,
              )!.pressing_services_dashboard_sub_title,
              onRegister: (List<PressingServiceModel>? newServices) {
                setState(() {
                  for (final newService in newServices ?? []) {
                    final index = servicesModels.indexWhere(
                      (service) => service.id == newService.id,
                    );

                    if (index == -1) {
                      servicesModels.add(newService);
                    } else {
                      servicesModels[index] = newService;
                    }
                  }
                });
              },
              onDelete: (int index) {
                setState(() {
                  servicesModels.removeAt(index);
                });
              },
              onChangeStatus: (int index) {
                setState(() {
                  servicesModels[index].isActive =
                      !(servicesModels[index].isActive ?? true);
                });
              },
            ),
            Theme.of(context).colorScheme.surface,
            [],
          ),
        ),
        ServiceCard(
          title: AppLocalizations.of(context)!.open_hours_title,
          icon: Icons.access_time,
          color: const Color.fromARGB(255, 12, 206, 19),
          onPress: () => MyAppFunctions.showMoveguiDialog(
            context,
            StoreOpenHoursDisplayWidget(
              openingHours: formController.weeklyHours,
              openingHoursChanged: (List<OpenHoursModel> newHoures) {},
              title: AppLocalizations.of(context)!.open_hours_title,
              subTitle: AppLocalizations.of(context)!.open_hours_sub_title,
              onRegister: (List<OpenHoursModel>? newOpeningHours) {
                if (newOpeningHours != null && newOpeningHours.isNotEmpty) {
                  setState(() {
                    formController.weeklyHours = newOpeningHours;
                  });
                }
              },
            ),

            Theme.of(context).colorScheme.surface,
            [],
          ),
          subtitleText: '$openTxt  $openDays / 7 $daysTxt',
        ),
        ServiceCard(
          title: AppLocalizations.of(context)!.module_add_name,
          icon: Icons.add_business,
          color: Colors.cyan,
          onPress: () {},
          subtitleText: ' ',
        ),
      ],
    );
  }

  Widget itemsWidget(DashboardModelData stats, DashboardService service) {
    return ResponsiveGrid(
      isVertical: true,
      children: [
        SizedBox(
          height: 160,
          child: KpiCard(
            item: ModuleItem(
              title: 'Commandes',
              value: stats.totalOrders.toString(),
              subtitle: '${stats.pendingOrders} en attente',
              icon: Icons.receipt_long_rounded,
            ),
            //      color: AppColors.moveGuiRed,
          ),
        ),
        SizedBox(
          height: 160,
          child: KpiCard(
            item: ModuleItem(
              title: 'Clients',
              value: stats.totalCustomers.toString(),
              subtitle: 'Utilisateurs clients',
              icon: Icons.people_alt_rounded,
            ),
            //  color: const Color(0xFF6A1B9A),
          ),
        ),
        SizedBox(
          height: 160,
          child: KpiCard(
            item: ModuleItem(
              title: 'Livreurs',
              value: stats.totalDrivers.toString(),
              subtitle: '${stats.onlineDrivers} connectés',
              icon: Icons.delivery_dining_rounded,
            ),
            //   color: AppColors.infoBlue,
          ),
        ),
        SizedBox(
          height: 160,
          child: KpiCard(
            item: ModuleItem(
              title: 'Revenus',
              value: service.formatGnf(stats.totalRevenue),
              subtitle: 'Total commandes payées',
              icon: Icons.payments_rounded,
            ),
            //  color: AppColors.successGreen,
          ),
        ),
      ],
    );
  }
}
