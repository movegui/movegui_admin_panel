import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movegui_admin_panel/models/store_model.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';

class StoreModelProvider with ChangeNotifier {
  final pressingService = getIt<PressingService>();
  String _storeId = "";
  String get storeId => _storeId;

  void setStoreId(String id) {
    _storeId = id;
    notifyListeners();
  }

  Future<StoreModel> getStore(String id) async{
    setStoreId(id);
    return pressingService.getModelById(id); 
  }

  static final storeProvider =
    FutureProvider.autoDispose.family<StoreModel, String>(
  (ref, storeId) async {
    return StoreModelProvider().getStore(storeId);
  },
);

static final storeModelProvider =
    ChangeNotifierProvider<StoreModelProvider>((ref) {
  return StoreModelProvider();
});

}
