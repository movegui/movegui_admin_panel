
import 'package:movegui_admin_panel/screens/main_screen.dart';




class CategoriesScreen extends MainScreen {
  const CategoriesScreen({super.key, required super.pageScreen});
  
}


class CategoriesPage extends MainPage {
  const CategoriesPage({super.key, required super.addModelWidget, required super.allModelWidget, required super.title});
  
}


/*
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
*/

