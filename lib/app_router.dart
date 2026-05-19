import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/inter_screen/all_products.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/providers/auth_provider.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/admin_screen.dart';
import 'package:movegui_admin_panel/screens/auth/movegui_forgot_password_screen.dart';
import 'package:movegui_admin_panel/screens/auth/movegui_register_screen.dart';
import 'package:movegui_admin_panel/screens/categories_screen.dart';
import 'package:movegui_admin_panel/screens/dashboard_screen.dart';
import 'package:movegui_admin_panel/screens/employe_screen.dart';
import 'package:movegui_admin_panel/screens/ingredients_screen.dart';
import 'package:movegui_admin_panel/screens/auth/login_screen.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/screens/movegui_profile_screen.dart';
import 'package:movegui_admin_panel/screens/patisserie_screen.dart';
import 'package:movegui_admin_panel/screens/pressing_screen.dart';
import 'package:movegui_admin_panel/screens/professionel_screen.dart';
import 'package:movegui_admin_panel/screens/recipes_screen.dart';
import 'package:movegui_admin_panel/screens/restaurant_screen.dart';
import 'package:movegui_admin_panel/screens/restaurant_type_screen.dart';
import 'package:movegui_admin_panel/screens/store_categories_screen.dart';
import 'package:movegui_admin_panel/screens/super_markt_screen.dart';
import 'package:movegui_admin_panel/screens/supplier_screen.dart';
import 'package:movegui_admin_panel/widgets/app/admin/add_admin_widget.dart';
import 'package:movegui_admin_panel/widgets/app/admin/all_admin_widget.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/app/employe/add_employe_widget.dart';
import 'package:movegui_admin_panel/widgets/app/employe/all_employe_widget.dart';
import 'package:movegui_admin_panel/widgets/app/main/main_page_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/add_pressing_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/all_pressing_widget.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class AppRouter {
  //final BuildContext context;
  // AppRouter({required this.context});
  static final routerProvider = Provider<GoRouter>((ref) {
    final authAsync = ref.watch(authStateProvider);

    return GoRouter(
      initialLocation: RouteConstants.SPLASH_ROUTE,

      // ✅ GoRouter refreshes when FirebaseAuth changes
      refreshListenable: GoRouterRefreshStream(
        FirebaseAuth.instance.authStateChanges(),
      ),

      // ✅ GLOBAL auth redirect (THIS IS THE KEY)
      redirect: (context, state) {
        if (authAsync.isLoading) {
          return RouteConstants.SPLASH_ROUTE; // ✅ DO NOTHING
        }

        final user = authAsync.value;

        final isAuthRoute =
            state.matchedLocation == RouteConstants.LOGIN_ROUTE ||
            state.matchedLocation == RouteConstants.REGISTER_ROUTE ||
            state.matchedLocation == RouteConstants.FORGET_PASSWORD_ROUTE;

        final isSplash = state.matchedLocation == RouteConstants.SPLASH_ROUTE;

        if (user == null && !isAuthRoute) {
          return RouteConstants.LOGIN_ROUTE;
        }

        if (user != null && (isAuthRoute || isSplash)) {
          return RouteConstants.HOME_ROUTE;
        }
        return null;
      },

      routes: [
        GoRoute(
          path: RouteConstants.LOGIN_ROUTE,
          builder: (context, state) => LoginScreen(),
        ),

        GoRoute(
          path: RouteConstants.FORGET_PASSWORD_ROUTE,
          builder: (context, state) => MoveguiForgotPasswordScreen(),
        ),
        GoRoute(
          path: RouteConstants.REGISTER_ROUTE,
          builder: (context, state) => MoveguiRegisterScreen(),
        ),
        GoRoute(
          path: RouteConstants.FORGET_PASSWORD_ROUTE,
          builder: (context, state) => MoveguiForgotPasswordScreen(),
        ),
        GoRoute(
          path: RouteConstants.HOME_ROUTE,
          builder: (context, state) =>
              MainScreen(pageScreen: DashboardScreen()),
        ),

        // 🔐 PROTECTED SHELL
        ShellRoute(
          builder: (context, state, child) {
            return Consumer(
              builder: (context, ref, _) {
                final title = getTitle(state.matchedLocation, context, ref);
                /*
                ref
                    .read(AppbarTitleProvider.appbarTitleProvider)
                    .title;
                    */
                return Scaffold(
                  appBar: AdminPanelAppBar(title: title),
                  drawer: Responsive.isMobile(context) ? SideMenu() : null,
                  body: child,
                );
              },
            );
          },

          routes: [
            GoRoute(
              path: RouteConstants.SPLASH_ROUTE,
              builder: (context, state) =>
                  const Center(child: CircularProgressIndicator()),
            ),

            GoRoute(
              path: RouteConstants.CATEGORY_ROUTE,
              builder: (context, state) => CategoriesScreen(
                pageScreen: CategoriesPage(
                  addModelWidget: MainPageWidget(
                    //                widget: CategoryAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.CATEGORY_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //               widget: AllCategoriesWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add_all,
                      tooltipText: AppLocalizations.of(context)!.tooltip_all,
                      enabled: true,
                      routeName: RouteConstants.CATEGORY_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.SUPPLIER_ROUTE,
              builder: (context, state) => SupplierScreen(
                pageScreen: SupplierPage(
                  addModelWidget: MainPageWidget(
                    //               widget: SupplierAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.SUPPLIER_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //               widget: AllSuppliersWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add_all,
                      tooltipText: AppLocalizations.of(context)!.tooltip_all,
                      enabled: true,
                      routeName: RouteConstants.SUPPLIER_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.INGREDIENT_ROUTE,
              builder: (context, state) => IngredientsScreen(
                pageScreen: IngredientsPage(
                  addModelWidget: MainPageWidget(
                    //              widget: IngredientsAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.INGREDIENT_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //              widget: AllIngredientsWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add_all,
                      tooltipText: AppLocalizations.of(context)!.tooltip_all,
                      enabled: true,
                      routeName: RouteConstants.INGREDIENT_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.RECIPE_ROUTER,
              builder: (context, state) => CreateRecettePage(),
            ),
            GoRoute(
              path: RouteConstants.PRODUCT_ROUTE,
              builder: (context, state) => ProductScreen(),
            ),
            GoRoute(
              path: RouteConstants.RESTAURANT_ROUTE,
              builder: (context, state) => RestaurantsScreen(
                pageScreen: RestaurantsPage(
                  addModelWidget: MainPageWidget(
                    //           widget: RestaurantAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.RESTAURANT_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //              widget: AllRestaurantsWidget(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add_all,
                      tooltipText: AppLocalizations.of(context)!.tooltip_all,
                      enabled: true,
                      routeName: RouteConstants.RESTAURANT_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.RESTAURANT_TYPE_ROUTE,
              builder: (context, state) => RestaurantTypeScreen(
                pageScreen: RestaurantTypePage(
                  addModelWidget: MainPageWidget(
                    //            widget: RestaurantTypeAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.RESTAURANT_TYPE_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //             widget: AllRestaurantTypeWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add_all,
                      tooltipText: AppLocalizations.of(context)!.tooltip_all,
                      enabled: true,
                      routeName: RouteConstants.RESTAURANT_TYPE_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.STORE_CATEGORY_ROUTE,
              builder: (context, state) => StoreCategoriesScreen(
                pageScreen: StoreCategoriesPage(
                  addModelWidget: MainPageWidget(
                    //            widget: StoreCategoriesAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.STORE_CATEGORY_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //             widget: AllStoreCatgoriesWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add_all,
                      tooltipText: AppLocalizations.of(context)!.tooltip_all,
                      enabled: true,
                      routeName: RouteConstants.STORE_CATEGORY_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.PASTRY_ROUTE,
              builder: (context, state) => PatisserieScreen(
                pageScreen: PatisseriePage(
                  addModelWidget: MainPageWidget(
                    //           widget: PatisserieAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.PASTRY_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //         widget: AllPatisserieWidget(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add_all,
                      tooltipText: AppLocalizations.of(context)!.tooltip_all,
                      enabled: true,
                      routeName: RouteConstants.PASTRY_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.SUPER_MARKET_ROUTE,
              builder: (context, state) => SuperMarktScreen(
                pageScreen: SuperMarktPage(
                  addModelWidget: MainPageWidget(
                    //         widget: SuperMarktAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.CATEGORY_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //       widget: AllSuperMarktWidget(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add_all,
                      tooltipText: AppLocalizations.of(context)!.tooltip_all,
                      enabled: true,
                      routeName: RouteConstants.CATEGORY_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.PRESSING_ROUTE,
              builder: (context, state) => PressingScreen(),
            ),
            GoRoute(
              path: RouteConstants.PRESSING_ADD_ROUTE,
              builder: (context, state) => AddPressingWidget(),
            ),
            GoRoute(
              path: RouteConstants.PRESSING_ALL_ROUTE,
              builder: (context, state) => AllPressingWidget(),
            ),
            GoRoute(
              path: RouteConstants.PROFESSIONEL_ROUTE,
              builder: (context, state) => ProfessionelScreen(
                pageScreen: ProfessionnelPage(
                  addModelWidget: MainPageWidget(
                    //         widget: ProfessionnelAddWidgetPage(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.PROFESSIONEL_ADD_ROUTE,
                      onPress: () {},
                    ),
                  ),
                  allModelWidget: MainPageWidget(
                    //    widget: AllProfessionnelWidget(),
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.add,
                      tooltipText: AppLocalizations.of(context)!.tooltip_add,
                      enabled: true,
                      routeName: RouteConstants.PROFESSIONEL_ALL_ROUTE,
                      onPress: () {},
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.PROFILE_ROUTE,
              builder: (context, state) {
                return MoveguiProfileScreen();
              },
            ),
            GoRoute(
              path: RouteConstants.ADMIN_ROUTE,
              builder: (context, state) => AdminScreen(),
            ),
            GoRoute(
              path: RouteConstants.ADMIN_ADD_ROUTE,
              builder: (context, state) => AddAdminWidget(),
            ),
            GoRoute(
              path: RouteConstants.ADMIN_ALL_ROUTE,
              builder: (context, state) => AllAdminWidget(),
            ),
            GoRoute(
              path: RouteConstants.EMPLOYE_ROUTE,
              builder: (context, state) => EmployeScreen(),
            ),
            GoRoute(
              path: RouteConstants.EMPLOYE_ADD_ROUTE,
              builder: (context, state) => AddEmployeWidget(),
            ),
            GoRoute(
              path: RouteConstants.EMPLOYE_ALL_ROUTE,
              builder: (context, state) => AllEmployeWidget(),
            ),
          ],
        ),
      ],
    );
  });

  static String getTitle(
    String routeName,
    BuildContext context,
    WidgetRef ref,
  ) {
    switch (routeName) {
      case RouteConstants.CATEGORY_ROUTE:
        return AppLocalizations.of(context)!.category_category_name;

      case RouteConstants.INGREDIENT_ROUTE:
        return AppLocalizations.of(context)!.category_ingredient_name;
      case RouteConstants.NOTIFICATION_ROUTE:
        return AppLocalizations.of(context)!.notification_title;
      case RouteConstants.PASTRY_ROUTE:
        return AppLocalizations.of(context)!.category_pastry_name;
      case RouteConstants.PRESSING_ROUTE:
        return AppLocalizations.of(context)!.pressing_bar_title;
      case RouteConstants.PRESSING_ADD_ROUTE:
        return AppLocalizations.of(context)!.pressing_add_bar_title;
      case RouteConstants.PRESSING_ALL_ROUTE:
        return AppLocalizations.of(context)!.pressing_all_bar_title;
      case RouteConstants.PRODUCT_ROUTE:
        return AppLocalizations.of(context)!.category_product_name;
      case RouteConstants.PROFESSIONEL_ROUTE:
        return AppLocalizations.of(context)!.category_profession_name;
      case RouteConstants.PROFILE_ROUTE:
        return AppLocalizations.of(context)!.profile_title;
      case RouteConstants.RECIPE_ROUTER:
        return AppLocalizations.of(context)!.category_recipe_name;
      case RouteConstants.RESTAURANT_ROUTE:
        return AppLocalizations.of(context)!.category_restaurant_name;
      case RouteConstants.RESTAURANT_TYPE_ROUTE:
        return AppLocalizations.of(context)!.menu_restaurant_type;
      case RouteConstants.SEARCH_ROUTE:
        return AppLocalizations.of(context)!.search_title;
      case RouteConstants.STORE_CATEGORY_ROUTE:
        return AppLocalizations.of(context)!.menu_store_categories;
      case RouteConstants.SUPER_MARKET_ROUTE:
        return AppLocalizations.of(context)!.category_super_market_name;
      case RouteConstants.SUPPLIER_ROUTE:
      case RouteConstants.ADMIN_ROUTE:
        return AppLocalizations.of(context)!.admin_bar_title;
      case RouteConstants.ADMIN_ADD_ROUTE:
        return AppLocalizations.of(context)!.admin_add_bar_title;
      case RouteConstants.ADMIN_ALL_ROUTE:
        return AppLocalizations.of(context)!.admin_all_bar_title;
      case RouteConstants.EMPLOYE_ROUTE:
        return AppLocalizations.of(context)!.employe_bar_title;
      case RouteConstants.EMPLOYE_ADD_ROUTE:
        return AppLocalizations.of(context)!.employe_add_bar_title;
      case RouteConstants.EMPLOYE_ALL_ROUTE:
        return AppLocalizations.of(context)!.employe_all_bar_title;
      default:
        return '';
    }
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
