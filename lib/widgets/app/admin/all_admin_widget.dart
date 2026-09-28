import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/users/user_display_widget.dart';

class AllAdminWidget extends StatefulWidget {
  const AllAdminWidget({super.key});

  @override
  State<StatefulWidget> createState() => AllAdminWidgetState();
}

class AllAdminWidgetState extends State<AllAdminWidget> {
  List<UserModel> users = [];
  late UserService userService;

  @override
  void initState() {
    userService = getIt<UserService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allUsers = await userService.getAllModelsByRole(UserRole.Admin);
    setState(() {
      users = allUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserDisplayWidget(
        users: users,
        title: AppLocalizations.of(context)!.admin_add_dashboard_title,
        subTitle: AppLocalizations.of(context)!.admin_add_dashboard_sub_title,
        onRegister: (addUsers) {
          if (addUsers == null || addUsers.isEmpty) {
            return;
          }
          setState(() {
            users.addAll(addUsers);
          });
        },
      ),
    );
  }
}
