import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/users/user_display_screen.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget_title.dart';

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
      body: UserDisplayScreen(users: users)
    );
  }

}
