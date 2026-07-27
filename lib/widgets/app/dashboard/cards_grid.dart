import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashbord_cards.dart';

import '../../../responsive.dart';

class CardsGrid extends StatefulWidget {
  const CardsGrid({super.key});

  @override
  State<CardsGrid> createState() => _CardsGridState();
}

class _CardsGridState extends State<CardsGrid> {
  late List<String> titles = [];

  Future<List<String>> initTitles() async {
    final myTitles = [
      AppLocalizations.of(context)!.module_category_name,
      AppLocalizations.of(context)!.module_supplier_name,
      AppLocalizations.of(context)!.module_ingredient_name,
      AppLocalizations.of(context)!.module_recipe_name,
      AppLocalizations.of(context)!.module_product_name,
      AppLocalizations.of(context)!.menu_menu,
      AppLocalizations.of(context)!.module_restaurant_name,
      AppLocalizations.of(context)!.menu_store_type,
      AppLocalizations.of(context)!.module_category_name,
      AppLocalizations.of(context)!.module_pastry_name,
      AppLocalizations.of(context)!.module_super_market_name,
      AppLocalizations.of(context)!.module_pressing_name,
      AppLocalizations.of(context)!.module_profession_name,
    ];
    return myTitles;
  }

  late int categories = 0,
      suppliers = 0,
      ingredients = 0,
      recips = 0,
      products = 0,
      restaurantMenus = 0,
      restaurants = 0,
      restaurantsType = 0,
      storeCategories = 0,
      patisseries = 0,
      superMarkts = 0,
      pressings = 0,
      professionnels = 0;
  final values = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      titles = await initTitles();
    });

    FirebaseFirestore.instance
        .collection('categories_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((ingredientsCatgeorySnapshot) {
          setState(() {
            categories = ingredientsCatgeorySnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('suppliers_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((ingredientsSupplierSnapshot) {
          setState(() {
            suppliers = ingredientsSupplierSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('ingredients_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((ingredientSnapshot) {
          setState(() {
            ingredients = ingredientSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('recipes_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((recipesSnapshot) {
          setState(() {
            recips = recipesSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('products_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((productsSnapshot) {
          setState(() {
            products = productsSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('restaurants_menu_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((restaurantsMenusSnapshot) {
          setState(() {
            restaurantMenus = restaurantsMenusSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('restaurants_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((restaurantsSnapshot) {
          setState(() {
            restaurants = restaurantsSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('restaurant_type_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((restaurantsTypesSnapshot) {
          setState(() {
            restaurantsType = restaurantsTypesSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('store_category_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((storeCategoriesSnapshot) {
          setState(() {
            storeCategories = storeCategoriesSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('patisseries_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((patisseriesSnapshot) {
          setState(() {
            patisseries = patisseriesSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('superMarkts_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((superMarktsSnapshot) {
          setState(() {
            superMarkts = superMarktsSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('pressings_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((pressingsSnapshot) {
          setState(() {
            pressings = pressingsSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('professionnels_model')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((professionsSnapshot) {
          setState(() {
            professionnels = professionsSnapshot.docs.length;
          });
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    values.clear();
    values.add(categories.toString());
    values.add(suppliers.toString());
    values.add(ingredients.toString());
    values.add(recips.toString());
    values.add(products.toString());
    values.add(restaurantMenus.toString());
    values.add(restaurants.toString());
    values.add(restaurantsType.toString());
    values.add(storeCategories.toString());
    values.add(patisseries.toString());
    values.add(superMarkts.toString());
    values.add(pressings.toString());
    values.add(professionnels.toString());

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: titles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: Responsive.isDesktop(context) ? 3 : 2,
        crossAxisSpacing: 10,
        crossAxisCount: Responsive.isDesktop(context)
            ? 4
            : Responsive.isTablet(context)
            ? 3
            : 2,
      ),
      itemBuilder: (context, index) {
        return DashBordCards(title: titles[index], value: values[index]);
      },
    );
  }
}
