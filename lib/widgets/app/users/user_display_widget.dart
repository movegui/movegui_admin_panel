import 'package:flutter/material.dart';
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
  late UserModel defaultUser;
  late SeedService seedService;

  @override
  void initState() {
    userFormService = getIt<UserFormService>();
    seedService = getIt<SeedService>();
    formControllers = [];
    if (widget.users.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        formControllers = await userFormService.getFormControllers(
          widget.users,
        );
      });
    } else {
      defaultUser = userFormService.getDefaultModel();
    }
    /*
   else{
   // defaultUser = user
   }
   */
    super.initState();
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
          //  leading: Icon(Icons.person),
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
                  // leading: Icon(Icons.person),
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
                    defaultUser.role = UserRole.Owner;
                    final formController = await userFormService
                        .getFormController(defaultUser);
                    MyAppFunctions.showMoveguiDialog(
                      context,
                      AddContactWidget(
                        formControllers: formControllers.isEmpty
                            ? [formController]
                            : formControllers
                                  .where((elem) => elem.role == UserRole.Owner)
                                  .toList(),
                        title: title,
                        subTitle: subTitle,
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
                            Expanded(child: registerButton(UserRole.Owner)),
                          ],
                        ),
                      ],

                      /*
                      AppLocalizations.of(context)!.owner_add_dashboard_title,
                      AppLocalizations.of(
                        context,
                      )!.owner_add_dashboard_sub_title,
                      */
                    );
                  },
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.btn_add_manager,
                  icon: Icon(Icons.supervisor_account),
                  enabled: true,
                  routeName: '',
                  onTap: () async {
                    defaultUser.role = UserRole.Manager;
                    final formController = await userFormService
                        .getFormController(defaultUser);
                    MyAppFunctions.showMoveguiDialog(
                      context,
                      AddContactWidget(
                        formControllers: formControllers.isEmpty
                            ? [formController]
                            : formControllers
                                  .where(
                                    (elem) => elem.role == UserRole.Manager,
                                  )
                                  .toList(),
                        title: title,
                        subTitle: subTitle,
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
                            Expanded(child: registerButton(UserRole.Manager)),
                          ],
                        ),
                      ],

                      /*
                      AppLocalizations.of(context)!.manager_add_dashboard_title,
                      AppLocalizations.of(
                        context,
                      )!.manager_add_dashboard_sub_title,
                      */
                    );
                  },
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.btn_add_employe,
                  icon: Icon(Icons.manage_accounts),
                  enabled: true,
                  routeName: '',
                  onTap: () async {
                    defaultUser.role = UserRole.Manager;
                    final formController = await userFormService
                        .getFormController(defaultUser);
                    MyAppFunctions.showMoveguiDialog(
                      context,
                      AddContactWidget(
                        formControllers: formControllers.isEmpty
                            ? [formController]
                            : formControllers
                                  .where(
                                    (elem) => elem.role == UserRole.Employe,
                                  )
                                  .toList(),
                        title: title,
                        subTitle: subTitle,
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
                            Expanded(child: registerButton(UserRole.Employe)),
                          ],
                        ),
                      ],

                      /*
                      AppLocalizations.of(context)!.employe_add_dashboard_title,
                      AppLocalizations.of(
                        context,
                      )!.employe_add_dashboard_sub_title,
                      */
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

  Widget registerButton(UserRole role) {
    return ButtonWidget(
      onPressed: (item) async {
        final users = await userFormService.getModels(
          formControllers.where((user) => user.role == role).toList(),
        );
        widget.onRegister.call(users);
      },
      buttonItem: ButtonInfo(
        title: AppLocalizations.of(context)!.btn_register_label,
        enabled: true,
      ),
      icon: Icon(Icons.save),
      textStyle: Theme.of(context).textTheme.displayMedium,
    );
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
