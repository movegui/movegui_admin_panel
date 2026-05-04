import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/providers/dark_theme_provider.dart';
import 'package:movegui_admin_panel/services/utils.dart';
import 'package:movegui_admin_panel/util/profile_menu_title.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

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
          _sectionCard([
            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_main,
              icon: Icons.home_filled,
              enabled: true,
              routeName: RouteConstants.HOME_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_categories,
              icon: Icons.category,
              enabled: false,
              routeName: RouteConstants.CATEGORY_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_supplier,
              icon: Icons.business,
              enabled: false,
              routeName: RouteConstants.SUPPLIER_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_ingredient,
              icon: Icons.emoji_food_beverage,
              enabled: false,
              routeName: RouteConstants.INGREDIENT_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_recipe,
              icon: Icons.icecream,
              enabled: false,
              routeName: RouteConstants.RECIPE_ROUTER,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_product,
              icon: Icons.shopping_bag,
              enabled: false,
              routeName: RouteConstants.PRODUCT_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_restaurant,
              icon: Icons.restaurant,
              enabled: false,
              routeName: RouteConstants.RESTAURANT_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_store_categories,
              icon: Icons.store,
              enabled: false,
              routeName: RouteConstants.STORE_CATEGORY_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_pastry,
              icon: Icons.cake,
              enabled: false,
              routeName: RouteConstants.PASTRY_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_super_market,
              icon: Icons.store,
              enabled: false,
              routeName: RouteConstants.SUPER_MARKET_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_pressing,
              icon: Icons.touch_app,
              enabled: true,
              routeName: RouteConstants.PRESSING_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.menu_professionel,
              icon: Icons.work,
              enabled: false,
              routeName: RouteConstants.PROFESSIONEL_ROUTE,
            ),

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
            ProfileMenuTitle(
              title: FirebaseAuth.instance.currentUser != null
                  ? AppLocalizations.of(context)!.profile_menu_logout
                  : AppLocalizations.of(context)!.profile_menu_login,
              icon: FirebaseAuth.instance.currentUser != null
                  ? IconlyBold.login
                  : IconlyBold.logout,
              enabled: true,
              routeName: FirebaseAuth.instance.currentUser != null
                  ? RouteConstants.LOGOUT_ROUTE
                  : RouteConstants.LOGIN_ROUTE,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _sectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(
          children.length,
          (index) => Column(
            children: [
              children[index],
              if (index != children.length - 1)
                const Divider(height: 2, indent: 56),
            ],
          ),
        ),
      ),
    );
  }
}
