import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/providers/auth_provider.dart';
import 'package:movegui_admin_panel/providers/current_user_provider.dart';
import 'package:movegui_admin_panel/providers/dark_theme_provider.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/permission_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/profile_menu_title.dart';

class SideMenu extends ConsumerWidget {
  SideMenu({super.key});
  final userService = getIt<UserService>();

  void onPress(BuildContext context, WidgetRef ref, String routeName) {
    context.go(routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authRoles);
    final theme = ref.read(DarkThemeProvider.themeProvider).getDarkTheme;
    final themeState = ref.read(
      DarkThemeProvider.themeProvider,
    ); //Provider.of<DarkThemeProvider>(context);
    final Color drawerColor = themeState.getDarkTheme
        ? const Color(0xFF1a1f3c)
        : Colors.white;

    return authState.when(
      data: (user) {
        if (user == null) {
          return Text(
            AppLocalizations.of(context)!.error_authorization,
            style: TextStyle(color: AppColors.error),
          );
        }

        final currentUser = ref
            .watch(CurrentUserProvider.currentUserProvider)
            .currentUser;

        if (currentUser == null ||
            user.uid != currentUser.id ||
            user.role != currentUser.role) {
          return Text(
            AppLocalizations.of(context)!.error_authorization,
            style: TextStyle(color: AppColors.error),
          );
        }

        const allowedRoles = {'Employe', 'Admin', 'SuperAdmin'};

        if (!allowedRoles.contains(user.role)) {
          return Text(
            AppLocalizations.of(context)!.error_authorization,
            style: TextStyle(color: AppColors.error),
          );
        }

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
                  title: AppLocalizations.of(
                    context,
                  )!.category_super_market_name,
                  icon: Icons.store,
                  enabled: false,
                  routeName: RouteConstants.SUPER_MARKET_ROUTE,
                ),

                ProfileMenuTitle(
                  title: AppLocalizations.of(context)!.category_pressing_name,
                  icon: Icons.touch_app,
                  enabled: true,
                  routeName: RouteConstants.PRESSING_ROUTE,
                  onTap: () => {
                    context.go(RouteConstants.PRESSING_ROUTE)
                  },
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
                    ref.read(DarkThemeProvider.themeProvider).setDarkTheme =
                        value;
                  },
                ),

                currentUser.role == UserRole.SuperAdmin.name &&
                        user.role == UserRole.SuperAdmin.name
                    //   permissioService.isSuperAdmin()
                    ? ProfileMenuTitle(
                        title: AppLocalizations.of(
                          context,
                        )!.category_admin_manager,
                        icon: Icons.person_add,
                        enabled: true,
                        routeName: RouteConstants.ADMIN_ROUTE,
                        onTap: () {
                          ref
                              .read(AppbarTitleProvider.appbarTitleProvider)
                              .setTitle(
                                AppLocalizations.of(
                                  context,
                                )!.category_admin_manager,
                              );
                          onPress(context, ref, RouteConstants.ADMIN_ROUTE);
                        },
                      )
                    : SizedBox(),

                //    permissioService.isAdmin()
                {'Admin', 'SuperAdmin'}.contains(user.role) &&
                        {'Admin', 'SuperAdmin'}.contains(currentUser.role)
                    ? ProfileMenuTitle(
                        title: AppLocalizations.of(
                          context,
                        )!.category_employe_manager,
                        icon: Icons.person_add,
                        enabled: true,
                        routeName: RouteConstants.EMPLOYE_ROUTE,
                        onTap: () {
                          ref
                              .read(AppbarTitleProvider.appbarTitleProvider)
                              .setTitle(
                                AppLocalizations.of(
                                  context,
                                )!.category_admin_manager,
                              );
                          onPress(context, ref, RouteConstants.EMPLOYE_ROUTE);
                        },
                      )
                    : SizedBox(),

                SizedBox(height: WidgetConstants.sepWidget),
              ]),
            ],
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
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
