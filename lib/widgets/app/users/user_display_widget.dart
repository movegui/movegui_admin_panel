import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/form_services/user_form_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/menu_tile.dart';
import 'package:movegui_admin_panel/util/user_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/users/user_tab_header_widget.dart';
import 'package:movegui_admin_panel/widgets/app/users/user_tab_row_widget.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class UserDisplayWidget extends StatefulWidget {
  final List<UserModel> users;
  final String title;
  final String subTitle;
  final void Function(int index) onDelete;
  final void Function(int index) onChangeStatus;
  final void Function(List<UserModel>? users) onRegister;

  const UserDisplayWidget({
    super.key,
    required this.users,
    required this.title,
    required this.subTitle,
    required this.onRegister,
    required this.onDelete,
    required this.onChangeStatus,
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
        ? await seedService.getGeneratedUserModel(role)
        : userFormService.getDefaultModel();
    model.role = role;
    final formController = await userFormService.getFormController(model);
    _trackFormController(formController);
    return formController;
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
            _showCreateMenu(context, widget.title, widget.subTitle);
          },
          buttonText: AppLocalizations.of(context)!.btn_create,
        ),
        const SizedBox(height: WidgetConstants.sepWidget),
        UserTabHeaderWidget(),
        const SizedBox(height: WidgetConstants.sepWidget),
        ...widget.users.map(
          (user) => UserTabRowWidget(
            user: user,
            onEdit: (value) async {
              await _editService(
                updatedUser: value,
                context: context,
                title: '',
                subTitle: '',
              );
            },
            onDelete: (value) async {
              await _deleteService(context, value);
            },
            onChangeStatus: (value) async {
              _changeUserStatus(value);
            },
          ),
        ),
      ],
    );
  }

  Future<void> showUserDisplayWidget({
    required List<UserFormController> controllers,
    required String title,
    required String subTitle,
    String? buttonTitle,
    Color? color,
    required UserRole role,
    required BuildContext dialogContext,
  }) async {
    MyAppFunctions.showMoveguiDialog(
      context,
      AddContactWidget(
        key: addContactKey,
        formControllers: controllers,
        title: title,
        subTitle: subTitle,
        onFormControllerAdded: _trackFormController,
        buttonTitle:
            buttonTitle ?? AppLocalizations.of(dialogContext)!.btn_create,
      ),
      color ?? AppColors.card,
      [
        Row(
          children: [
            Expanded(child: cancelButton()),
            SizedBox(width: WidgetConstants.sepWidgetWidth * 2),
            Expanded(child: registerButton(role, dialogContext, controllers)),
          ],
        ),
      ],
    );
  }

  Future<void> _createUser({
    required UserRole role,
    required BuildContext context,
    required String title,
    required String subTitle,
    Color? color,
  }) async {
    showUserDisplayWidget(
      controllers: [await _addEmptyFormController(role)],
      title: title,
      subTitle: subTitle,
      role: role,
      dialogContext: context,
      color: color,
    );
  }

  Future<void> _editService({
    required UserModel? updatedUser,
    required BuildContext context,
    required String title,
    required String subTitle,
    Color? color,
  }) async {
    showUserDisplayWidget(
      controllers: [await userFormService.getFormController(updatedUser)],
      title: title,
      subTitle: subTitle,
      role: updatedUser?.role ?? UserRole.Guest,
      dialogContext: context,
      color: color,
    );
  }

  Future<void> _deleteService(
    BuildContext dialogContext,
    UserModel userToDelete,
  ) async {
    final result = await MyAppFunctions.showConfirmationDialog(
      context: context,
      title: AppLocalizations.of(context)!.delete_pressing_service_title,
      question: AppLocalizations.of(context)!.delete_pressing_service_question,
    );
    if (result) {
      final index = widget.users
          .indexWhere((serv) => serv.id == userToDelete.id)
          .toInt();
      if (index == -1) {
        return;
      }
      widget.onDelete.call(index);
      setState(() {});
    }
  }

  void _changeUserStatus(UserModel userToChange) {
    final index = widget.users
        .indexWhere((serv) => serv.id == userToChange.id)
        .toInt();
    if (index == -1) {
      return;
    }
    widget.onChangeStatus.call(index);
    setState(() {});
    debugPrint('Change status: ${userToChange.name}');
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
                    _createUser(
                      role: UserRole.Owner,
                      context: context,
                      title: title,
                      subTitle: subTitle,
                      color: Colors.blue,
                    );
                  },
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.btn_add_manager,
                  icon: Icon(Icons.supervisor_account),
                  enabled: true,
                  routeName: '',
                  onTap: () async {
                    _createUser(
                      role: UserRole.Manager,
                      context: context,
                      title: title,
                      subTitle: subTitle,
                      color: Colors.purple,
                    );
                  },
                ),

                MenuTile(
                  title: AppLocalizations.of(context)!.btn_add_employe,
                  icon: Icon(Icons.manage_accounts),
                  enabled: true,
                  routeName: '',
                  onTap: () async {
                    _createUser(
                      role: UserRole.Employe,
                      context: context,
                      title: title,
                      subTitle: subTitle,
                      color: Colors.green,
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
