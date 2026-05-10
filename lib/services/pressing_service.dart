
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/pressing_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class PressingService extends ModelService<PressingModel>{
  PressingService({required super.api});

  
  @override
  Future<void> addModel(PressingModel pressing) async{
        await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(pressing.id)
          .set(pressing.toJson());
  }

  @override
  Future<List<PressingModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => PressingModel.fromJson(doc.data())).toList();
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
}