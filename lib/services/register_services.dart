import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:movegui_admin_panel/config/env.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/services/address_service.dart';
import 'package:movegui_admin_panel/services/api_service.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/form_services/adress_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/person_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_article_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_type_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/user_form_service.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/ingredients_service.dart';
import 'package:movegui_admin_panel/services/patisseries_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/professionnel_service.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/services/store_categories_service.dart';
import 'package:movegui_admin_panel/services/super_markts_service.dart';
import 'package:movegui_admin_panel/services/suppliers_service.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';
import 'package:movegui_admin_panel/util/pressing_form_controller.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:movegui_admin_panel/util/pressing_service_type_form_controller.dart';
import 'package:movegui_admin_panel/util/product_form_controller.dart';
import 'package:movegui_admin_panel/util/user_form_controller.dart';

final getIt = GetIt.instance;

void initServices(Env env) {
  // getIt.registerLazySingleton<CategoriesService>(() => CategoriesService());
  final api = ApiService(env);
  getIt.registerLazySingleton<StoreCategoriesService>(
    () => StoreCategoriesService(api: api),
  );
  getIt.registerLazySingleton<SuppliersService>(
    () => SuppliersService(api: api),
  );
  getIt.registerLazySingleton<IngredientsService>(
    () => IngredientsService(api: api),
  );
  getIt.registerLazySingleton<RestaurantsService>(
    () => RestaurantsService(api: api),
  );
  getIt.registerLazySingleton<RestaurantTypeService>(
    () => RestaurantTypeService(api: api),
  );
  getIt.registerLazySingleton<PatisseriesService>(
    () => PatisseriesService(api: api),
  );
  getIt.registerLazySingleton<SuperMarktsService>(
    () => SuperMarktsService(api: api),
  );
  getIt.registerLazySingleton<PressingService>(() => PressingService(api: api));
  getIt.registerLazySingleton<ProfessionnelService>(
    () => ProfessionnelService(api: api),
  );
  getIt.registerLazySingleton<UserService>(() => UserService(api: api));
  getIt.registerLazySingleton<ImageService>(() => ImageService());
  getIt.registerLazySingleton<AddressService>(() => AddressService(api: api));
  getIt.registerLazySingleton<SeedService>(
    () => SeedService(api: api, faker: Faker()),
  );
    getIt.registerLazySingleton<DashboardService>(() => DashboardService(api: api));
  getIt.registerLazySingleton<AdressFormService>(
    () => AdressFormService(
      api: api,
      seedService: getIt<SeedService>(),
      controllerFactory: () {
        return AddressFormController();
      },
    ),
  );
  getIt.registerLazySingleton<PersonFormService>(
    () => PersonFormService(
      api: api,
      adressFormService: getIt<AdressFormService>(),
      seedService: getIt<SeedService>(),
      controllerFactory: () {
        return PersonFormController();
      },
    ),
  );

  getIt.registerLazySingleton<UserFormService>(
    () => UserFormService(
      personFormService: getIt<PersonFormService>(),
      api: api,
      controllerFactory: () {
        return UserFormController();
      },
      seedService: getIt<SeedService>(),
    ),
  );

  getIt.registerLazySingleton<PressingServicesTypeFormService>(
    () => PressingServicesTypeFormService(
      seedService: getIt<SeedService>(),
      controllerFactory: () {
        return PressingServiceTypeFormController();
      },
      api: api,
    ),
  );

  getIt.registerLazySingleton<PressingArticleFormService>(
    () => PressingArticleFormService(
      seedService: getIt<SeedService>(),
      controllerFactory: () {
        return ProductFormController<PressingArticleModel>();
      },
      api: api,
    ),
  );

  getIt.registerLazySingleton<PressingServicesFormService>(
    () => PressingServicesFormService(
      seedService: getIt<SeedService>(),
      controllerFactory: () {
        return PressingServiceFormController();
      },
      api: api,
      servicesTypeFormService: getIt<PressingServicesTypeFormService>(),
      articleFormService: getIt<PressingArticleFormService>(),
    ),
  );

  getIt.registerLazySingleton<PressingFormService>(
    () => PressingFormService(
      api: api,
      userFormService: getIt<UserFormService>(),
      seedService: getIt<SeedService>(),
      controllerFactory: () {
        return PressingFormController();
      },
      servicesFormService: getIt<PressingServicesFormService>(),
    ),
  );

  //
}
