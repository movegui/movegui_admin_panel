import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/services/types_service.dart';

class PressingServicesTypesService
    extends TypesService<PressingServiceTypeModel> {
  PressingServicesTypesService({required super.api});

  @override
  Future<PressingServiceTypeModel> addModel(
    PressingServiceTypeModel model,
  ) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .set(model.toJson());
    return model;
  }

  @override
  Future<List<PressingServiceTypeModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();

    return snapshot.docs
        .map((doc) => PressingServiceTypeModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> deleteModel(PressingServiceTypeModel model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .delete();
  }

  @override
  Future<List<PressingServiceTypeModel>> getByName(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('name', isEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => PressingServiceTypeModel.fromJson(doc.data()))
        .toList();
  }

  @override
  String getCollectionName() {
    return "pressing_services_types_model";
  }

  @override
  Future<PressingServiceTypeModel> getModelById(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();
    return PressingServiceTypeModel.fromJson(snapshot.data()!);
  }
}
