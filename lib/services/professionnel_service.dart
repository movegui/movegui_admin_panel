
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/professionnel_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class ProfessionnelService extends ModelService<ProfessionnelModel>{
  ProfessionnelService({required super.api});


  @override
  Future<ProfessionnelModel> addModel(ProfessionnelModel professionnel) async {
     await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(professionnel.id)
          .set(professionnel.toJson());
      return professionnel;
  }

  @override
  Future<List<ProfessionnelModel>> allModels() async {
         final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => ProfessionnelModel.fromJson(doc.data())).toList();
  }

  @override
  Future<List<ProfessionnelModel>> getByName(String name) async {
                  final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => ProfessionnelModel.fromJson(doc.data()))
      .toList();
  }

  @override
  String getCollectionName() {
    return "professionnels_model";
  }

  
}