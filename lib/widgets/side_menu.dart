import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/providers/dark_theme_provider.dart';
import 'package:movegui_admin_panel/screens/categories_screen.dart';
import 'package:movegui_admin_panel/screens/dashboard_screen.dart';
import 'package:movegui_admin_panel/screens/ingredients_screen.dart';
import 'package:movegui_admin_panel/screens/patisserie_screen.dart';
import 'package:movegui_admin_panel/screens/pressing_screen.dart';
import 'package:movegui_admin_panel/screens/product_screen.dart';
import 'package:movegui_admin_panel/screens/professionel_screen.dart';
import 'package:movegui_admin_panel/screens/restaurant_type_screen.dart';
import 'package:movegui_admin_panel/screens/super_markt_screen.dart';
import 'package:movegui_admin_panel/screens/supplier_screen.dart';
import 'package:movegui_admin_panel/screens/login_screen.dart';
import 'package:movegui_admin_panel/screens/recipes_screen.dart';
import 'package:movegui_admin_panel/screens/restaurant_screen.dart';
import 'package:movegui_admin_panel/services/utils.dart';
import 'package:movegui_admin_panel/widgets/add_person_widget.dart';
import 'package:movegui_admin_panel/widgets/app/ingredients/add_ingredient_widget.dart';
import 'package:movegui_admin_panel/widgets/app/ingredients/all_ingredient_widget.dart';
import 'package:movegui_admin_panel/widgets/app/patisserie/add_patisserie_widget.dart';
import 'package:movegui_admin_panel/widgets/app/patisserie/all_patisserie_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/add_pressing_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/all_pressing_widget.dart';
import 'package:movegui_admin_panel/widgets/app/professionnel/add_professionnel_widget.dart';
import 'package:movegui_admin_panel/widgets/app/professionnel/all_professionnel_widget.dart';
import 'package:movegui_admin_panel/widgets/app/restaurants/add_restaurant_type._widget.dart';
import 'package:movegui_admin_panel/widgets/app/restaurants/add_restaurants_widget.dart';
import 'package:movegui_admin_panel/widgets/app/restaurants/all_restaurant_type_widget.dart';
import 'package:movegui_admin_panel/widgets/app/restaurants/all_restaurants_widget.dart';
import 'package:movegui_admin_panel/widgets/app/superMartkt/add_super_markt_widget.dart';
import 'package:movegui_admin_panel/widgets/app/superMartkt/all_super_markt_widget.dart';
import 'package:movegui_admin_panel/widgets/app/suppliers/add_suppliers_widget.dart';
import 'package:movegui_admin_panel/widgets/app/suppliers/all_suppliers_widget.dart';
import 'package:movegui_admin_panel/widgets/app/categories/add_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/app/categories/all_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import '../inter_screen/orders_screen.dart';
import '../screens/main_screen.dart' hide CategoryPage;

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color drawerColor = themeState.getDarkTheme
        ? const Color(0xFF1a1f3c)
        : Colors.white;
    return Drawer(
      backgroundColor: drawerColor,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/moveguiB.jpg'),
                fit: BoxFit.contain,
              ),
            ),
            child: Text(''),
          ),
          //           child: Image.asset('assets/icons/moveguiB.jpg'),),
          DrawerListTile(
            title: "Main",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      const MainScreen(pageScreen: DashboardScreen()),
                ),
              );
            },
            icon: Icons.home_filled,
          ),

          DrawerListTile(
            title: "Categories",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesScreen(
                    pageScreen: CategoriesPage(
                      addModelWidget: CategoryAddWidgetPage(),
                      allModelWidget: AllCategoriesWidgetPage(),
                      title: 'Categories',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

          DrawerListTile(
            title: "Fournisseurs",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SupplierScreen(
                    pageScreen: SupplierPage(
                      addModelWidget: SupplierAddWidgetPage(),
                      allModelWidget: AllSuppliersWidgetPage(),
                      title: 'Fournisseurs',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

          DrawerListTile(
            title: "Ingredients",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const IngredientsScreen(
                    pageScreen: IngredientsPage(
                      addModelWidget: IngredientsAddWidgetPage(),
                      allModelWidget: AllIngredientsWidgetPage(),
                      title: 'Ingredients',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

          DrawerListTile(
            title: "Recettes",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CreateRecettePage()),
              );
            },
            icon: Icons.icecream,
          ),

          DrawerListTile(
            title: "Produits",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProductScreen()),
              );
            },
            icon: Icons.icecream,
          ),

          DrawerListTile(
            title: "Restaurants",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RestaurantsScreen(
                    pageScreen: RestaurantsPage(
                      addModelWidget: RestaurantAddWidgetPage(),
                      allModelWidget: AllRestaurantsWidget(),
                      title: 'Restaurants',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

          DrawerListTile(
            title: "Restaurants Type",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RestaurantTypeScreen(
                    pageScreen: RestaurantTypePage(
                      addModelWidget: RestaurantTypeAddWidgetPage(),
                      allModelWidget: AllRestaurantTypeWidgetPage(),
                      title: 'Restaurants Types',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

          DrawerListTile(
            title: "Patisserie",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PatisserieScreen(
                    pageScreen: PatisseriePage(
                      addModelWidget: PatisserieAddWidgetPage(),
                      allModelWidget: AllPatisserieWidget(),
                      title: 'Patisserie',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

          DrawerListTile(
            title: "Super Marchés",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SuperMarktScreen(
                    pageScreen: SuperMarktPage(
                      addModelWidget: SuperMarktAddWidgetPage(),
                      allModelWidget: AllSuperMarktWidget(),
                      title: 'Super Marchés',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

          
          DrawerListTile(
            title: "Pressing",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PressingScreen(
                    pageScreen: PressingPage(
                      addModelWidget: PressingAddWidgetPage(),
                      allModelWidget: AllPressingWidgetPage(),
                      title: 'Pressing',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

                    DrawerListTile(
            title: "Professionnel",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfessionelScreen(
                    pageScreen: ProfessionnelPage(
                      addModelWidget: ProfessionnelAddWidgetPage(),
                      allModelWidget:  AllProfessionnelWidget(),
                      title: 'Professionnel',
                    ),
                  ),
                ),
              );
            },
            icon: Icons.icecream,
          ),

          /*
          DrawerListTile(
            title: "View all product",
            press: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ProductScreen()));
            },
            icon: Icons.store,
          ),
          DrawerListTile(
            title: "View all order",
            press: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const OrderScreen()));
            },
            icon: IconlyBold.bag_2,
          ),
          */
          SwitchListTile(
            title: const Text('Theme'),
            secondary: Icon(
              themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            value: theme,
            onChanged: (value) {
              setState(() {
                themeState.setDarkTheme = value;
              });
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.45),
          // DrawerListTile(
          //   title: "Settings",
          //   press: () {
          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OrderScreen()));
          //   },
          //   icon: IconlyBold.setting,
          // ),
          DrawerListTile(
            title: "Sign out",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            icon: IconlyBold.logout,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = theme == true ? Colors.white : Colors.black;

    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(icon, size: 18),
      title: TextWidget(text: title, color: color),
    );
  }
}
