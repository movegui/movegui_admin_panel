import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dash_board_side_menu.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/add_pressing_page.dart';
import 'package:movegui_admin_panel/widgets/web/main_page.dart';

class AddPressingScreen extends StatelessWidget {
  const AddPressingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPage(
            sideWidget: DashBoardSideMenu(),
            mainWidget: AddPressingPage()
          );
  } 
  
}