
import 'package:get_it/get_it.dart';
import 'package:movegui_admin_panel/services/categories_service.dart';
import 'package:movegui_admin_panel/services/ingredients_service.dart';
import 'package:movegui_admin_panel/services/patisseries_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/professionnel_service.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/services/super_markts_service.dart';
import 'package:movegui_admin_panel/services/suppliers_service.dart';

final getIt = GetIt.instance;

void initServices(){
  getIt.registerLazySingleton<CategoriesService>(() => CategoriesService());
  getIt.registerLazySingleton<SuppliersService>(() => SuppliersService());
  getIt.registerLazySingleton<IngredientsService>(() => IngredientsService());
  getIt.registerLazySingleton<RestaurantsService>(() => RestaurantsService());
  getIt.registerLazySingleton<RestaurantTypeService>(() => RestaurantTypeService());
  getIt.registerLazySingleton<PatisseriesService>(() => PatisseriesService());
  getIt.registerLazySingleton<SuperMarktsService>(() => SuperMarktsService());
  getIt.registerLazySingleton<PressingService>(() => PressingService());
  getIt.registerLazySingleton<ProfessionnelService>(() => ProfessionnelService());
}