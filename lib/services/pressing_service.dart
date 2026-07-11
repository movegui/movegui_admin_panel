import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class PressingService extends ModelService<PressingModel> {
  PressingService({required super.api});

  @override
  Future<PressingModel> addModel(PressingModel pressing) async {
    print(FirebaseAuth.instance.currentUser?.uid);
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(pressing.id)
        .set(pressing.toJson());
    return pressing;
  }

  @override
  Future<List<PressingModel>> allModels() async {
    
final user = FirebaseAuth.instance.currentUser;

final tokenResult = await user?.getIdTokenResult(true);

print('UID: ${user?.uid}');
print('CLAIMS: ${tokenResult?.claims}');

    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();

    return snapshot.docs
        .map((doc) => PressingModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<PressingModel>> getByName(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('name', isEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => PressingModel.fromJson(doc.data()))
        .toList();
  }

  @override
  String getCollectionName() {
    return "pressings_model";
  }

  Future<PressingModel> addServices(
    PressingModel pressing,
    List<PressingServiceModel> services,
  ) async {
    for (final service in services) {
      await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(pressing.id)
          .collection(service.getCollectionName())
          .doc(service.id)
          .set(service.toJson());
    }
    return pressing;
  }
  
  @override
  Future<PressingModel> getModelById(String id) async {
    final snapshot =  await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(id)
          .get();
    return PressingModel.fromJson(snapshot.data()!);         
  }
}
