import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class CategoriesService extends ModelService<CategoriesModel> {


  @override
  Future<void> addModel(CategoriesModel ingredient) async {
    await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(ingredient.id)
          .set(ingredient.toJson());
  }
  
@override
Future<List<CategoriesModel>> allModels() async {
  final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => CategoriesModel.fromJson(doc.data())).toList();
}
  
  @override
  String getCollectionName() {
   return "categories_model";
  }
  
  @override
  Future<List<CategoriesModel>> getByName(String name) async {
      final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => CategoriesModel.fromJson(doc.data()))
      .toList();
  }

  


  
}