import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/providers/dark_theme_provider.dart';
import 'package:movegui_admin_panel/util/profile_menu_title.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final theme = ref.read(DarkThemeProvider.themeProvider).getDarkTheme;
    final themeState = ref.read(DarkThemeProvider.themeProvider); //Provider.of<DarkThemeProvider>(context);
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
              title: AppLocalizations.of(context)!.category_category_name,
              icon: Icons.category,
              enabled: false,
              routeName: RouteConstants.CATEGORY_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.category_supplier_name,
              icon: Icons.business,
              enabled: false,
              routeName: RouteConstants.SUPPLIER_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.category_ingredient_name,
              icon: Icons.emoji_food_beverage,
              enabled: false,
              routeName: RouteConstants.INGREDIENT_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.category_recipe_name,
              icon: Icons.icecream,
              enabled: false,
              routeName: RouteConstants.RECIPE_ROUTER,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.category_product_name,
              icon: Icons.shopping_bag,
              enabled: false,
              routeName: RouteConstants.PRODUCT_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.category_restaurant_name,
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
              title: AppLocalizations.of(context)!.category_pastry_name,
              icon: Icons.cake,
              enabled: false,
              routeName: RouteConstants.PASTRY_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.category_super_market_name,
              icon: Icons.store,
              enabled: false,
              routeName: RouteConstants.SUPER_MARKET_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.category_pressing_name,
              icon: Icons.touch_app,
              enabled: true,
              routeName: RouteConstants.PRESSING_ROUTE,
            ),

            ProfileMenuTitle(
              title: AppLocalizations.of(context)!.category_profession_name,
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
                ref.read(DarkThemeProvider.themeProvider).setDarkTheme = value;
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
