
import 'package:get_it/get_it.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/ingredients_service.dart';
import 'package:movegui_admin_panel/services/patisseries_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/professionnel_service.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/services/store_categories_service.dart';
import 'package:movegui_admin_panel/services/super_markts_service.dart';
import 'package:movegui_admin_panel/services/suppliers_service.dart';
import 'package:movegui_admin_panel/services/user_service.dart';

final getIt = GetIt.instance;

void initServices(){
 // getIt.registerLazySingleton<CategoriesService>(() => CategoriesService());
  getIt.registerLazySingleton<StoreCategoriesService>(() => StoreCategoriesService());
  getIt.registerLazySingleton<SuppliersService>(() => SuppliersService());
  getIt.registerLazySingleton<IngredientsService>(() => IngredientsService());
  getIt.registerLazySingleton<RestaurantsService>(() => RestaurantsService());
  getIt.registerLazySingleton<RestaurantTypeService>(() => RestaurantTypeService());
  getIt.registerLazySingleton<PatisseriesService>(() => PatisseriesService());
  getIt.registerLazySingleton<SuperMarktsService>(() => SuperMarktsService());
  getIt.registerLazySingleton<PressingService>(() => PressingService());
  getIt.registerLazySingleton<ProfessionnelService>(() => ProfessionnelService());
  getIt.registerLazySingleton<UserService>(() => UserService());
  getIt.registerLazySingleton<ImageService>(() => ImageService());
}