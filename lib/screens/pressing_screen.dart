
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/app/main/add_model_btn_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class PressingScreen extends MainScreen{
  const PressingScreen({super.key, required super.pageScreen});
}

class PressingPage extends MainPage {
  const PressingPage({super.key, required super.addModelWidget, required super.allModelWidget, required super.title});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: title)
          : AdminPanelAppBar(title: title),
      drawer: SideMenu(),
      */
      body: Column(
        children: [
          Row(
            children: [
               AddModelBtnWidget(addModelWidget: addModelWidget,),

                const Spacer(),

              CustomButon(
                text: 'View All',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(pageScreen: allModelWidget),
                    ),
                  );
                },
                icon: Icons.list_alt,
              ),
        
            ],
          ),
        ],
      ),
    );
  }
}