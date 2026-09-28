import 'dart:core';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
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
import 'package:movegui_admin_panel/widgets/app/service_card.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_widget.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/kpi_card.dart';
import 'package:movegui_admin_panel/widgets/app/users/user_display_widget.dart';

class AddPressingPage extends StatefulWidget {
  const AddPressingPage({super.key});
  final String collectionName = 'pressings';

  @override
  State<StatefulWidget> createState() => PressingAddWidgetPageState();
}

class PressingAddWidgetPageState extends State<AddPressingPage> {
  final formController = PressingFormController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late PressingService pressingService;
  late PressingFormService formService;
  late SeedService seedService;
  late UserService userService;
  late final DashboardService dashboardService;
  DashboardModel dashboardModel = DashboardModel.empty();
  bool _isLoadingDashboard = false;
  late List<UserModel> users;
  late List<PressingServiceModel> servicesModel;

  @override
  void initState() {
    super.initState();
    pressingService = getIt<PressingService>();
    formService = getIt<PressingFormService>();
    seedService = getIt<SeedService>();
    userService = getIt<UserService>();
    dashboardService = getIt<DashboardService>();
    users = [];
    servicesModel = [];
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final generatedUser = await seedService.getGeneratedUserModel();
      if (!mounted) {
        return;
      }
      setState(() {
        userModel = generatedUser;
      });
    });
    */
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isLoadingDashboard) {
      return;
    }
    _isLoadingDashboard = true;
    final service = await seedService.getGeneratedPressingService();
    if (!mounted) {
      return;
    }
    formController.services?.add(service);
    await loadDatatest();
    _isLoadingDashboard = false;
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

  Future<void> loadDatatest() async {
    if (seedService.api.env is EnvDev) {
      final pressingTestData = await seedService.generatePressing();
      final model = await dashboardService.loadDashboardItems(
        FirebaseFirestore.instance,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        formController.setData(pressingTestData);
        dashboardModel = model;
      });
    }
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
        formController.pickedImage == null ||
        formController.userForms.any(
          (userForm) =>
              userForm.personForm.pickedImage == null ||
              userForm.personForm.birthdate == null ||
              userForm.personForm.gender == null,
        )) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_title,
        AppLocalizations.of(context)!.error_send_formular,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      formController.contacts = await formService.userFormService.getModels(
        formController.userForms,
      );

      if (formController.weeklyHours.isNotEmpty &&
          formController.contacts.isNotEmpty) {
        await submitHandler.submit(form: formController);
        showAlertBar(
          context,
          AppLocalizations.of(context)!.store_add_success_message(
            AppLocalizations.of(context)!.module_pressing_name,
          ),
        );
        if (mounted) {
          context.go(RouteConstants.PRESSING_ROUTE);
        }
      }
    } catch (e) {
      print(e.toString());
      showBtmAlert(context, e.toString());
    }

    setState(() => isLoading = false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
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
                      itemsWidget(dashboardModel, dashboardService),
                      const SizedBox(height: 16),
                      OrderStatusPanel(models: dashboardModel),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buidContent() {
    return SafeArea(
      child: SingleChildScrollView(
        //      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Center(
          //  child: ConstrainedBox(
          //   constraints: const BoxConstraints(maxWidth: 1120),
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
                  buttonText: AppLocalizations.of(context)!.btn_all,
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
                    formController.addressForm.selectedMunicipality = value!;
                  },
                  //    textColor: AppColors.textColor,
                  onHoursChanged: (List<OpenHoursModel> hours) {
                    formController.weeklyHours = hours;
                  },
                ),

                const SizedBox(height: WidgetConstants.sepWidget),

                _buildServiceCard(context, users, servicesModel),

                /*
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: PressingServiceWidget(
                        formControllers: formController.serviceForms,
                        onServiceChange:
                            (int index, PressingServiceTypeModel? value) {
                              setState(() {
                                formController.serviceForms[index].serviceType =
                                    value;
                              });
                            },
                      ),
                    ),
                  ),
                  */
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
              onRegister: (List<UserModel>? owners) {
                users.addAll(owners ?? []);
              },
            ),
            Colors.blue,
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
              onRegister: (List<UserModel>? managers) {
                users.addAll(managers ?? []);
              },
            ),
            Colors.purple,
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
              onRegister: (List<UserModel>? employees) {
                users.addAll(employees ?? []);
              },
            ),
            Colors.green,
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
            Text('To Implement !!!!!'),
            null,
            [],
          ),
        ),
        ServiceCard(
          title: AppLocalizations.of(context)!.open_hours_title,
          icon: Icons.access_time,
          color: const Color.fromARGB(255, 12, 206, 19),
          onPress: () {},
          subtitleText: ' ',
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

  /*

  void _showUserDialog(
    BuildContext context,
    List<UserModel> users,
    String title,
    String subTitle,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final size = MediaQuery.sizeOf(dialogContext);
        return Dialog(
          backgroundColor: AppColors.lightBackground,
          child: SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.6,
            child: UserDisplayWidget(
              users: users,
              title: title,
              subTitle: subTitle,
            ),
          ),
        );
      },
    );
  }

  void _showServicesDialog(
    BuildContext context,
    List<PressingServiceModel> servicesModel,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final size = MediaQuery.sizeOf(dialogContext);
        return Dialog(
          child: SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.8,
            child: Text('To Implement !!!'), //UserDisplayScreen(users: users),
          ),
        );
      },
    );
  }

*/

  Widget itemsWidget(DashboardModel stats, DashboardService service) {
    return ResponsiveGrid(
      isVertical: true,
      children: [
        SizedBox(
          height: 160,
          child: KpiCard(
            title: 'Commandes',
            value: stats.totalOrders.toString(),
            subtitle: '${stats.pendingOrders} en attente',
            icon: Icons.receipt_long_rounded,
            //      color: AppColors.moveGuiRed,
          ),
        ),
        SizedBox(
          height: 160,
          child: KpiCard(
            title: 'Clients',
            value: stats.totalCustomers.toString(),
            subtitle: 'Utilisateurs clients',
            icon: Icons.people_alt_rounded,
            //  color: const Color(0xFF6A1B9A),
          ),
        ),
        SizedBox(
          height: 160,
          child: KpiCard(
            title: 'Livreurs',
            value: stats.totalDrivers.toString(),
            subtitle: '${stats.onlineDrivers} connectés',
            icon: Icons.delivery_dining_rounded,
            //   color: AppColors.infoBlue,
          ),
        ),
        SizedBox(
          height: 160,
          child: KpiCard(
            title: 'Revenus',
            value: service.formatGnf(stats.totalRevenue),
            subtitle: 'Total commandes payées',
            icon: Icons.payments_rounded,
            //  color: AppColors.successGreen,
          ),
        ),
      ],
    );
  }
}
