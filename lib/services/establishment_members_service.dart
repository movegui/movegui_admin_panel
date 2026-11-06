import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_members_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class EstablishmentMembersService
    extends ModelService<EstablishmentMembersModel> {
  EstablishmentMembersService({required super.fromJson, required super.api});

  @override
  String getCollectionName() {
    return MoveGuiCollections.COLLECTION_ESTABLISHMENTS_MEMBERS;
  }

  Future<List<EstablishmentMembersModel>> getMembers(String storeId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('storeId', isEqualTo: storeId)
        .get();
    return snapshot.docs
        .map((doc) => fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  Future<List<EstablishmentMembersModel>> getSores(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }
}
