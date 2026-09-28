import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movegui_admin_panel/consts/theme_provider.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/providers/address_provider.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/providers/shopping_provider.dart';
import 'package:movegui_admin_panel/providers/store_provider.dart';
import 'package:movegui_admin_panel/providers/user_provider.dart';
import 'package:movegui_admin_panel/services/address_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';

final shoppingProviderState = ChangeNotifierProvider<ShoppingProvider>((ref) {
  return ShoppingProvider();
});

final storeProviderState = ChangeNotifierProvider<StoreProvider>((ref) {
  return StoreProvider();
});

final userProviderState = ChangeNotifierProvider<UserProvider>((ref) {
  return UserProvider();
});

final appbarTitleProviderState = ChangeNotifierProvider<AppbarTitleProvider>((
  ref,
) {
  return AppbarTitleProvider();
});

final addressProviderState = ChangeNotifierProvider<AddressProvider>((ref) {
  return AddressProvider();
});

final themeProvider = ChangeNotifierProvider<ThemeProvider>(
  (ref) => ThemeProvider(),
);

/*
final previousRouteProviderState = ChangeNotifierProvider<PreviousRouteProvider>((ref) {
  return PreviousRouteProvider();
});
*/

final currentAddressProvider = FutureProvider<AdressModel?>((ref) async {
  final service = getIt<AddressService>();
  return service.getCurrentAddress(null);
});

// previousRouteProvider
