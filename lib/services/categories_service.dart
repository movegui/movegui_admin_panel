import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

abstract class CategoriesService<M extends CategoriesModel> extends ModelService<M> {


  @override
  Future<void> addModel(M model) async {
    await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(model.id)
          .set(model.toJson());
  }

  /*
  
@override
Future<List<M>> allModels() async {
  final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .get();

  return snapshot.docs.map((doc) => M.fromJson(doc.data())).toList();
}
*/
  
  /*
  @override
  String getCollectionName() {
   return "categories_model";
  }
  */
  
  /*
  @override
  Future<List<M>> getByName(String name) async {
      final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => M.fromJson(doc.data()))
      .toList();
  }
  */

  


  
}