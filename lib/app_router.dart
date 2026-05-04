import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/inter_screen/all_products.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
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

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouteConstants.HOME_ROUTE,
        builder: (context, state) => MainScreen(pageScreen: DashboardScreen()),
      ),
      GoRoute(
        path: RouteConstants.CATEGORY_ROUTE,
        builder: (context, state) => CategoriesScreen(
          pageScreen: CategoriesPage(
            addModelWidget: CategoryAddWidgetPage(),
            allModelWidget: AllCategoriesWidgetPage(),
            title: AppLocalizations.of(context)!.menu_categories,
          ),
        ),
      ),
      GoRoute(
        path: RouteConstants.SUPPLIER_ROUTE,
        builder: (context, state) => SupplierScreen(
          pageScreen: SupplierPage(
            addModelWidget: SupplierAddWidgetPage(),
            allModelWidget: AllSuppliersWidgetPage(),
            title: AppLocalizations.of(context)!.menu_supplier,
          ),
        ),
      ),
      GoRoute(
        path: RouteConstants.INGREDIENT_ROUTE,
        builder: (context, state) => IngredientsScreen(
          pageScreen: IngredientsPage(
            addModelWidget: IngredientsAddWidgetPage(),
            allModelWidget: AllIngredientsWidgetPage(),
            title: AppLocalizations.of(context)!.menu_ingredient,
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
            title: AppLocalizations.of(context)!.menu_restaurant,
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
            title: AppLocalizations.of(context)!.menu_pastry,
          ),
        ),
      ),
      GoRoute(
        path: RouteConstants.SUPER_MARKET_ROUTE,
        builder: (context, state) => SuperMarktScreen(
          pageScreen: SuperMarktPage(
            addModelWidget: SuperMarktAddWidgetPage(),
            allModelWidget: AllSuperMarktWidget(),
            title: AppLocalizations.of(context)!.menu_super_market,
          ),
        ),
      ),
      GoRoute(
        path: RouteConstants.PRESSING_ROUTE,
        builder: (context, state) => PressingScreen(
          pageScreen: PressingPage(
            addModelWidget: PressingAddWidgetPage(),
            allModelWidget: AllPressingWidgetPage(),
            title: AppLocalizations.of(context)!.menu_pressing,
          ),
        ),
      ),
      GoRoute(
        path: RouteConstants.PROFESSIONEL_ROUTE,
        builder: (context, state) => ProfessionelScreen(
          pageScreen: ProfessionnelPage(
            addModelWidget: ProfessionnelAddWidgetPage(),
            allModelWidget: AllProfessionnelWidget(),
            title: AppLocalizations.of(context)!.menu_professionel,
          ),
        ),
      ),
      GoRoute(
        path: RouteConstants.PROFILE_ROUTE,
        builder: (context, state) => MoveguiProfileScreen(),
      ),
      GoRoute(
        path: RouteConstants.LOGIN_ROUTE,
        builder: (context, state) => LoginScreen(),
      ),

      GoRoute(path: RouteConstants.FORGET_PASSWORD_ROUTE, builder: (context, state) => MoveguiForgotPasswordScreen(),),
      GoRoute(path: RouteConstants.REGISTER_ROUTE, builder: (context, state) => MoveguiRegisterScreen(),)
    ],
  );
}
