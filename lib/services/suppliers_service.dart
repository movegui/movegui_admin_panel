import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/supplier_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class SuppliersService extends ModelService<SupplierModel>{
  SuppliersService({required super.api});


  @override
  Future<void> addModel(SupplierModel model) async {
        await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(model.id)
          .set(model.toJson());
  }

  @override
  Future<List<SupplierModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => SupplierModel.fromJson(doc.data())).toList();
  }

  @override
  String getCollectionName() {
    return "suppliers_model";
  }

      @override
  Future<List<SupplierModel>> getByName(String name) async {
      final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => SupplierModel.fromJson(doc.data()))
      .toList();
  }

  
}