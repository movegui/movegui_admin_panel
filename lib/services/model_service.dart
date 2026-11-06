import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/services/api_service.dart';

abstract class ModelService<M extends Model> {
  final ApiService api;
  ModelService({ required this.fromJson, required this.api});
   final M Function(Map<String, dynamic> json) fromJson;

  String getCollectionName();

  Future<M> addModel(M model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .set(model.toJson());

    return model;
  }

  Future<List<M>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();

    return snapshot.docs
        .map((doc) => fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  Future<List<M>> getByName(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('name', isEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  Future<M> getModelById(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();
    return fromJson(snapshot.data()!);
  }

  Future<void> deleteModel(M model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .delete();
  }
}