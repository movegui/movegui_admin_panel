import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/form_services/user_form_service.dart';
import 'package:movegui_admin_panel/services/global_method.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/menu_tile.dart';
import 'package:movegui_admin_panel/util/user_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget_title.dart';

class UserDisplayWidget extends StatefulWidget {
  final List<UserModel> users;
  final String title;
  final String subTitle;
  final void Function(List<UserModel>? users) onRegister;

  const UserDisplayWidget({
    super.key,
    required this.users,
    required this.title,
    required this.subTitle,
    required this.onRegister,
  });

  @override
  State<StatefulWidget> createState() => UserDisplayWidgetState();
}

class UserDisplayWidgetState extends State<UserDisplayWidget> {
  late UserFormService userFormService;
  late List<UserFormController> formControllers;
  late SeedService seedService;
  final addContactKey = GlobalKey<AddContactWidgetState>();

  @override
  void initState() {
    userFormService = getIt<UserFormService>();
    seedService = getIt<SeedService>();
    formControllers = [];
    /*
   else{
   // defaultUser = user
   }
   */
    super.initState();
  }

  @override
  void dispose() {
    for (final formController in formControllers) {
      formController.dispose();
    }
    super.dispose();
  }

  void _trackFormController(UserFormController formController) {
    if (!formControllers.contains(formController)) {
      formControllers.add(formController);
    }
  }

  Future<UserFormController> _addEmptyFormController(UserRole role) async {
    final model = seedService.api.env is EnvDev
        ? await seedService.getGeneratedUserModel()
        : userFormService.getDefaultModel();
    model.role = role;
    final formController = await userFormService.getFormController(model);
    _trackFormController(formController);
    return formController;
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? buildDesktop(context)
        : buildMobile(context);
  }

  Widget buildMobile(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        DashboardHeader(
          title: widget.title,
          subtitle: widget.subTitle,
          onPressed: (item) async {
            _showCreateMenu(context, widget.title, widget.subTitle);
          },
          buttonText: AppLocalizations.of(context)!.btn_create,
        ),
        SizedBox(height: WidgetConstants.sepWidget),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DisplayWidgetTitle(
                text: AppLocalizations.of(context)!.label_name,
                textAlign: TextAlign.left,
              ),
              DisplayWidgetTitle(
                text: AppLocalizations.of(context)!.label_email,
              ),
              DisplayWidgetTitle(
                text: AppLocalizations.of(context)!.label_phone,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.users.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DisplayWidget(
                              text: widget.users[index].personModel!.name,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: DisplayWidget(
                              text: widget.users[index].personModel!.email,
                            ),
                          ),
                          Expanded(
                            child: DisplayWidget(
                              text: widget.users[index].personModel!.phone,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    GlobalMethods.showEmployeeBottomSheet(
                      context,
                      widget.users[index],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget buildDesktop(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        DashboardHeader(
          title: widget.title,
          subtitle: widget.subTitle,
          onPressed: (item) async {
            _showCreateMenu(context, widget.title, widget.subTitle);
          },
          buttonText: AppLocalizations.of(context)!.btn_create,
        ),
        SizedBox(height: WidgetConstants.sepWidget),
        ListTile(
          leading: Icon(Icons.person),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DisplayWidgetTitle(
                text: AppLocalizations.of(context)!.label_firstname,
              ),
              DisplayWidgetTitle(
                text: AppLocalizations.of(context)!.label_lastname,
              ),
              DisplayWidgetTitle(
                text: AppLocalizations.of(context)!.label_email,
              ),
              DisplayWidgetTitle(
                text: AppLocalizations.of(context)!.label_phone,
              ),
              DisplayWidgetTitle(
                text: AppLocalizations.of(context)!.label_role,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.users.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DisplayWidget(
                              text: widget.users[index].personModel!.firstName,
                            ),
                          ),
                          Expanded(
                            child: DisplayWidget(
                              text: widget.users[index].personModel!.lastName,
                            ),
                          ),
                          Expanded(
                            child: DisplayWidget(
                              text: widget.users[index].personModel!.email,
                            ),
                          ),

                          Expanded(
                            child: DisplayWidget(
                              text: widget.users[index].personModel!.phone,
                            ),
                          ),

                          Expanded(
                            child: DisplayWidget(
                              text: widget.users[index].role.name,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    GlobalMethods.showEmployeeBottomSheet(
                      context,
                      widget.users[index],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showCreateMenu(BuildContext context, String title, String subTitle) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuTile(
                  title: AppLocalizations.of(context)!.btn_add_owner,
                  icon: Icon(Icons.admin_panel_settings),
                  enabled: true,
                  routeName: '',
                  onTap: () async {
                    final ownerForms = [
                      await _addEmptyFormController(UserRole.Owner),
                    ];

                    MyAppFunctions.showMoveguiDialog(
                      context,
                      AddContactWidget(
                        key: addContactKey,
                        formControllers: ownerForms,
                        title: title,
                        subTitle: subTitle,
                        onFormControllerAdded: _trackFormController,
                        buttonTitle: AppLocalizations.of(
                          context,
                        )!.btn_add_owner,
                      ),
                      Colors.blue,
                      [
                        Row(
                          children: [
                            Expanded(child: cancelButton()),
                            SizedBox(width: WidgetConstants.sepWidgetWidth * 2),
                            Expanded(
                              child: registerButton(
                                UserRole.Owner,
                                context,
                                ownerForms,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.btn_add_manager,
                  icon: Icon(Icons.supervisor_account),
                  enabled: true,
                  routeName: '',
                  onTap: () async {
                    final managerForms = [
                      await _addEmptyFormController(UserRole.Manager),
                    ];
                    MyAppFunctions.showMoveguiDialog(
                      context,
                      AddContactWidget(
                        key: addContactKey,
                        formControllers: managerForms,
                        title: title,
                        subTitle: subTitle,
                        onFormControllerAdded: _trackFormController,
                        buttonTitle: AppLocalizations.of(
                          context,
                        )!.btn_add_manager,
                      ),
                      Colors.purple,
                      [
                        Row(
                          children: [
                            Expanded(child: cancelButton()),
                            SizedBox(width: WidgetConstants.sepWidgetWidth * 2),
                            Expanded(
                              child: registerButton(
                                UserRole.Manager,
                                context,
                                managerForms,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.btn_add_employe,
                  icon: Icon(Icons.manage_accounts),
                  enabled: true,
                  routeName: '',
                  onTap: () async {
                    final employeeForms = [
                      await _addEmptyFormController(UserRole.Employe),
                    ];
                    MyAppFunctions.showMoveguiDialog(
                      context,
                      AddContactWidget(
                        key: addContactKey,
                        formControllers: employeeForms,
                        title: title,
                        subTitle: subTitle,
                        onFormControllerAdded: _trackFormController,
                        buttonTitle: AppLocalizations.of(
                          context,
                        )!.btn_add_employe,
                      ),
                      Colors.green,
                      [
                        Row(
                          children: [
                            Expanded(child: cancelButton()),
                            SizedBox(width: WidgetConstants.sepWidgetWidth * 2),
                            Expanded(
                              child: registerButton(
                                UserRole.Employe,
                                context,
                                employeeForms,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget registerButton(
    UserRole role,
    BuildContext dialogContext,
    List<UserFormController> userForms,
  ) {
    return ButtonWidget(
      onPressed: (item) async {
        if (!validateAllPersons(userForms)) return;
        final newUsers = await userFormService.getModels(userForms);
        if (!mounted) return;
        widget.onRegister.call(newUsers);
        setState(() {
          for (final user in newUsers) {
            if (!widget.users.contains(user)) {
              widget.users.add(user);
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

  bool validateAllPersons(List<UserFormController> users) {
    var allValid = true;
    for (final user in users) {
      if (!user.isValid()) {
        allValid = false;
      }
    }
    return allValid;
  }

  Widget cancelButton() {
    return ButtonWidget(
      onPressed: (item) async {
        //context.push(RouteConstants.LOGIN_ROUTE);
      },
      buttonItem: ButtonInfo(
        title: AppLocalizations.of(context)!.btn_cancel_label,
        enabled: true,
      ),
      icon: Icon(Icons.cancel),
      textStyle: Theme.of(context).textTheme.displayMedium,
    );
  }
}
