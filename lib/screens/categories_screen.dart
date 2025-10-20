
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/categories/add_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/categories/all_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';




class CategoriesScreen extends MainScreen {
  const CategoriesScreen({super.key, required super.pageScreen});
  
}


class CategoryPage extends StatelessWidget {

  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context) ? AdminPanelAppBarDesktop(title: 'Categories') : AdminPanelAppBar(title: 'Categories'),
      drawer: SideMenu(),
      body:         Column(
      
                              children: [
                                Row(
                                  children: [
                                    CustomButon(text: 'View All',onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AllCategoriesWidget(pageScreen: AllCategoriesWidgetPage(),)));
                                    },icon: Icons.list_alt,),
                                    const Spacer(),
                                    CustomButon(text: 'Add New',onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCategoriesWidget(pageScreen: CategoryAddWidgetPage(),)));
                                    },icon: Icons.add,),
                                  ],
                                ),
                              ],
                            ),
    );
  }
  
}

