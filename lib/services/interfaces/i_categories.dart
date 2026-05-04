import 'package:flutter/material.dart';
import 'package:movegui/models/categories_model.dart';

abstract class ICategories {
  Future<List<CategoriesModel>> getAllCommandCategories();
  Future<List<CategoriesModel>> getCourseCategories();
  
  Future<void> onPressedImage(
    BuildContext context,
    String routeName,
    String title,
    bool enabled,
  );
}
