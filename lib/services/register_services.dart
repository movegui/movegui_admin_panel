
import 'package:get_it/get_it.dart';
import 'package:movegui_admin_panel/config/env.dart';
import 'package:movegui_admin_panel/services/api_service.dart';
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

void initServices(Env env){
 // getIt.registerLazySingleton<CategoriesService>(() => CategoriesService());
 final api = ApiService(env);
  getIt.registerLazySingleton<StoreCategoriesService>(() => StoreCategoriesService(api: api));
  getIt.registerLazySingleton<SuppliersService>(() => SuppliersService(api: api));
  getIt.registerLazySingleton<IngredientsService>(() => IngredientsService(api: api));
  getIt.registerLazySingleton<RestaurantsService>(() => RestaurantsService(api: api));
  getIt.registerLazySingleton<RestaurantTypeService>(() => RestaurantTypeService(api: api));
  getIt.registerLazySingleton<PatisseriesService>(() => PatisseriesService(api: api));
  getIt.registerLazySingleton<SuperMarktsService>(() => SuperMarktsService(api: api));
  getIt.registerLazySingleton<PressingService>(() => PressingService(api: api));
  getIt.registerLazySingleton<ProfessionnelService>(() => ProfessionnelService(api: api));
  getIt.registerLazySingleton<UserService>(() => UserService(api: api));
  getIt.registerLazySingleton<ImageService>(() => ImageService());
}