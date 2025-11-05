
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';


class IngredientsScreen extends MainScreen{
  const IngredientsScreen({super.key, required super.pageScreen});
}


class IngredientsPage extends MainPage {
  const IngredientsPage({super.key, required super.addModelWidget, required super.allModelWidget, required super.title});
  
}

/*

class IngredientsScreen extends StatelessWidget {
  const IngredientsScreen({super.key});


  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const SideMenu(),
        appBar: Responsive.isDesktop(context) ? AdminPanelAppBarDesktop(title: 'Ingredients') : AdminPanelAppBar(title: 'Ingredients'),
        body: Builder(
        builder: (context) => SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              const Expanded(
                flex: 5,
                child: IngredientPage(),
              ),
            ],
          ),
        ),
      )),
    );
  }
  
}



class IngredientPage extends StatelessWidget {

  const IngredientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('In Implementation..............'),
    );
  }
  
  
}
*/

  
