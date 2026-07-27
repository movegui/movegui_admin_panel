import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/users/user_display_screen.dart';

class AllManagerWidget extends StatefulWidget {
  const AllManagerWidget({super.key});

  @override
  State<StatefulWidget> createState() => AllEmployeWidgetState();
}

class AllEmployeWidgetState extends State<AllManagerWidget> {
  List<UserModel> users = [];
  late UserService userService;

  @override
  void initState() {
    userService = getIt<UserService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allUsers = await userService.getAllModelsByRole(UserRole.Manager);
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
