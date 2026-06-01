import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/ingredient_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class IngredientsService extends ModelService<IngredientModel> {
  IngredientsService({required super.api});

  @override
  Future<IngredientModel> addModel(IngredientModel ingredient) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(ingredient.id)
        .set(ingredient.toJson());
    return ingredient;
  }

  @override
  Future<List<IngredientModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();
    return snapshot.docs
        .map((doc) => IngredientModel.fromJson(doc.data()))
        .toList();
  }

  @override
  String getCollectionName() {
    return "ingredients_model";
  }

  @override
  Future<List<IngredientModel>> getByName(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('name', isEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => IngredientModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<IngredientModel> getModelById(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();
    return IngredientModel.fromJson(snapshot.data()!);
  }
}
