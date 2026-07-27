import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/users/user_display_screen.dart';

class AllDriverWidget extends StatefulWidget {
  const AllDriverWidget({super.key});

  @override
  State<StatefulWidget> createState() => AllDriverWidgetState();
}

class AllDriverWidgetState extends State<AllDriverWidget> {
  List<UserModel> users = [];
  late UserService userService;

  @override
  void initState() {
    userService = getIt<UserService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allUsers = await userService.getAllModelsByRole(UserRole.Driver);
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
