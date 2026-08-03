import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/product_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';


class ProductFormController<M extends ProductModel> extends FormController<M> {
  final name = TextEditingController();
  double price = 0.0;
  String? supplierId;
  bool isAvailable = false;
  String? imageUrl;
  String? category;
  String currency = 'GNF';
  List<String?>? materials;
  String? id;
  DateTime? createdAt;

  void dispose() {
    name.dispose();
  }

  void clear() {
    name.clear();
    price = 0.0;
    supplierId = null;
    isAvailable = false;
    imageUrl = null;
    category = null;
    currency = 'GNF';
    materials = [];
    id = null;
    createdAt = null;
  }

  @override
  Future<void> setData(M model) async {
    id = model.id;
    name.text = model.name;
    createdAt = model.createdAt;
    price = model.price ?? 0.0;
    supplierId = model.supplierId;
    isAvailable = model.isAvailable;
    imageUrl = model.imageUrl;
    category = model.category;
    currency = model.currency;
    materials = model.materials;
  }
}
