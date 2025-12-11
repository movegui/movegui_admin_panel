import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/dashbord_cards.dart';

import '../responsive.dart';

class CardsGrid extends StatefulWidget {
  CardsGrid({Key? key}) : super(key: key);

  @override
  State<CardsGrid> createState() => _CardsGridState();
}

class _CardsGridState extends State<CardsGrid> {
  final titles = [
    'Category',
    'Fournisseur',
    'Ingredient',
    'Recette',
    'Produit',
    'Menu',
    'Restaurant',
    'Store Types',
    'Store Categories',
    'Patisserie',
    'Super Marchés',
    'Pressing',
    'Professionnel',
  ];
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
        .collection('recipe')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((recipesSnapshot) {
          setState(() {
            recips = recipesSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('product')
        .snapshots(includeMetadataChanges: true)
        .first
        .then((productsSnapshot) {
          setState(() {
            products = productsSnapshot.docs.length;
          });
        });

    FirebaseFirestore.instance
        .collection('restaurant_menu')
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
    /*
    if (products == null) {
      return const Padding(
        padding: EdgeInsets.all(50),
        child: CircularProgressIndicator(),
      );
    } else {
      */
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
        childAspectRatio: Responsive.isDesktop(context) ? 3 : 2.9,
        crossAxisSpacing: 10,
        crossAxisCount: Responsive.isDesktop(context)
            ? 4
            : Responsive.isTablet(context)
            ? 2
            : 1,
      ),
      itemBuilder: (context, index) {
        return DashBordCards(
          title: titles[index],
          value:
              values[index], //index == 0 ? '\$ ${values[index]}' : values[index],
        );
      },
    );
  }
}
