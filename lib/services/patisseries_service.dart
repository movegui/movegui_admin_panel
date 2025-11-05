

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/patisserie_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class PatisseriesService extends ModelService<PatisserieModel>{
  @override
  Future<void> addModel(PatisserieModel patisserie) async {
       await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(patisserie.id)
          .set(patisserie.toJson());
  }

  @override
  Future<List<PatisserieModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => PatisserieModel.fromJson(doc.data())).toList();
  }

  @override
  Future<List<PatisserieModel>> getByName(String name) async{
          final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => PatisserieModel.fromJson(doc.data()))
      .toList();
  }

  @override
  String getCollectionName() {
    return "patisseries_model";
  }
}