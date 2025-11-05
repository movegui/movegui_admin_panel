import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/super_markt_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class SuperMarktsService extends ModelService<SuperMarktModel> {
  @override
  Future<void> addModel(SuperMarktModel superMarkt) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(superMarkt.id)
        .set(superMarkt.toJson());
  }

  @override
  Future<List<SuperMarktModel>> allModels() async {
     final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => SuperMarktModel.fromJson(doc.data())).toList();
  }

  @override
  Future<List<SuperMarktModel>> getByName(String name) async {
          final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => SuperMarktModel.fromJson(doc.data()))
      .toList();
  }

  @override
  String getCollectionName() {
    return "superMarkts_model";
  }
}
