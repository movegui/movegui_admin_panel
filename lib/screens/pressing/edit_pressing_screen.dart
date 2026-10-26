import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dash_board_side_menu.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_form_page.dart';
import 'package:movegui_admin_panel/widgets/web/main_page.dart';

class EditPressingScreen extends StatelessWidget {
  const EditPressingScreen({super.key, required this.pressingId});
  final String pressingId;

  @override
  Widget build(BuildContext context) {
    return MainPage(
            sideWidget: DashBoardSideMenu(),
            mainWidget: PressingFormPage(pressingId: pressingId,)
          );
  } 
  
}