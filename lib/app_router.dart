import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/inter_screen/all_products.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/providers/auth_provider.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/auth/movegui_forgot_password_screen.dart';
import 'package:movegui_admin_panel/screens/auth/movegui_register_screen.dart';
import 'package:movegui_admin_panel/screens/categories_screen.dart';
import 'package:movegui_admin_panel/screens/dashboard_screen.dart';
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
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/app/categories/add_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/app/categories/all_categories_widget.dart';
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
import 'package:movegui_admin_panel/widgets/app/store/add_store_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/all_store_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/app/superMartkt/add_super_markt_widget.dart';
import 'package:movegui_admin_panel/widgets/app/superMartkt/all_super_markt_widget.dart';
import 'package:movegui_admin_panel/widgets/app/suppliers/add_suppliers_widget.dart';
import 'package:movegui_admin_panel/widgets/app/suppliers/all_suppliers_widget.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';


class AppRouter {
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
                final title = ref
                    .watch(AppbarTitleProvider.appbarTitleProvider)
                    .title;
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
                  addModelWidget: CategoryAddWidgetPage(),
                  allModelWidget: AllCategoriesWidgetPage(),
                  title: AppLocalizations.of(context)!.category_category_name,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.SUPPLIER_ROUTE,
              builder: (context, state) => SupplierScreen(
                pageScreen: SupplierPage(
                  addModelWidget: SupplierAddWidgetPage(),
                  allModelWidget: AllSuppliersWidgetPage(),
                  title: AppLocalizations.of(context)!.category_supplier_name,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.INGREDIENT_ROUTE,
              builder: (context, state) => IngredientsScreen(
                pageScreen: IngredientsPage(
                  addModelWidget: IngredientsAddWidgetPage(),
                  allModelWidget: AllIngredientsWidgetPage(),
                  title: AppLocalizations.of(context)!.category_ingredient_name,
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
                  addModelWidget: RestaurantAddWidgetPage(),
                  allModelWidget: AllRestaurantsWidget(),
                  title: AppLocalizations.of(context)!.category_restaurant_name,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.RESTAURANT_TYPE_ROUTE,
              builder: (context, state) => RestaurantTypeScreen(
                pageScreen: RestaurantTypePage(
                  addModelWidget: RestaurantTypeAddWidgetPage(),
                  allModelWidget: AllRestaurantTypeWidgetPage(),
                  title: AppLocalizations.of(context)!.menu_store_type,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.STORE_CATEGORY_ROUTE,
              builder: (context, state) => StoreCategoriesScreen(
                pageScreen: StoreCategoriesPage(
                  addModelWidget: StoreCategoriesAddWidgetPage(),
                  allModelWidget: AllStoreCatgoriesWidgetPage(),
                  title: AppLocalizations.of(context)!.menu_store_categories,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.PASTRY_ROUTE,
              builder: (context, state) => PatisserieScreen(
                pageScreen: PatisseriePage(
                  addModelWidget: PatisserieAddWidgetPage(),
                  allModelWidget: AllPatisserieWidget(),
                  title: AppLocalizations.of(context)!.category_pastry_name,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.SUPER_MARKET_ROUTE,
              builder: (context, state) => SuperMarktScreen(
                pageScreen: SuperMarktPage(
                  addModelWidget: SuperMarktAddWidgetPage(),
                  allModelWidget: AllSuperMarktWidget(),
                  title: AppLocalizations.of(context)!.category_super_market_name,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.PRESSING_ROUTE,
              builder: (context, state) => PressingScreen(
                pageScreen: PressingPage(
                  addModelWidget: PressingAddWidgetPage(),
                  allModelWidget: AllPressingWidgetPage(),
                  title: AppLocalizations.of(context)!.category_pressing_name,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.PROFESSIONEL_ROUTE,
              builder: (context, state) => ProfessionelScreen(
                pageScreen: ProfessionnelPage(
                  addModelWidget: ProfessionnelAddWidgetPage(),
                  allModelWidget: AllProfessionnelWidget(),
                  title: AppLocalizations.of(context)!.category_profession_name,
                ),
              ),
            ),
            GoRoute(
              path: RouteConstants.PROFILE_ROUTE,
              builder: (context, state) {
                if (state.extra != null) {
                  final currentUser = state.extra as UserModel;
                  return MoveguiProfileScreen(currentUser: currentUser);
                }

                return MoveguiProfileScreen();
              },
            ),
          ],
        ),
      ],
    );
  });

  void updateTitle(String routeName, BuildContext context, WidgetRef ref){

      switch(routeName){
        case RouteConstants.CATEGORY_ROUTE: 
          ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_category_name);
          break;     
        case RouteConstants.INGREDIENT_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_ingredient_name);
        break;
        case RouteConstants.NOTIFICATION_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.notification_title);
        break;
        case RouteConstants.PASTRY_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_pastry_name);
        break;
        case RouteConstants.PRESSING_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_pressing_name);
        break;
        case RouteConstants.PRODUCT_ROUTE: 
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_product_name);
        break;
        case RouteConstants.PROFESSIONEL_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_profession_name);
        break;
        case RouteConstants.PROFILE_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.profile_title);
        break;
        case RouteConstants.RECIPE_ROUTER:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_recipe_name);
        break;
        case RouteConstants.RESTAURANT_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_restaurant_name);
        break;
        case RouteConstants.RESTAURANT_TYPE_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.menu_restaurant_type);
        break;
        case RouteConstants.SEARCH_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.search_title);
        break;
        case RouteConstants.STORE_CATEGORY_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.menu_store_categories);
        break;
        case RouteConstants.SUPER_MARKET_ROUTE:
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_super_market_name);
        break;
        case RouteConstants.SUPPLIER_ROUTE: 
        ref.read(AppbarTitleProvider.appbarTitleProvider).setTitle(AppLocalizations.of(context)!.category_supplier_name);
        break;
     

      }
  }
}



class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}


