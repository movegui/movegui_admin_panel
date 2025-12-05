import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/models/ingredient_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/ingredients_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class AllIngredientsWidgetPage extends StatefulWidget {
  const AllIngredientsWidgetPage({super.key});

  @override
  State<AllIngredientsWidgetPage> createState() => AllIngredientsWidgetState();
}

class AllIngredientsWidgetState extends State<AllIngredientsWidgetPage> {

  List<IngredientModel> ingredients = [];
  late IngredientsService ingredientsService;

  @override
  void initState() {
    ingredientsService = getIt<IngredientsService>(); //SuppliersService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allsuppliers = await ingredientsService.allModels();
    setState(() {
      ingredients = allsuppliers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'All Ingredients')
          : AdminPanelAppBar(title: 'All Ingredients'),
      drawer: SideMenu(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
                   Expanded(
                child: Text(
                  'Categorie',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Fournisseur',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
                   Expanded(
                child: Text(
                  'Unite',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
                   Expanded(
                child: Text(
                  'Allergique',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                   //   leading: Icon(Icons.business_center),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(ingredients[index].name),
                              ),
                                      Expanded(
                                child: Text(ingredients[index].category!.name),
                              ),
                              /*
                                      Expanded(
                                child: Text(ingredients[index].supplier!.company),
                              ),
                              */
                                      Expanded(
                                child: Text(ingredients[index].unit),
                              ),
                                      Expanded(
                                child: Text(ingredients[index].isAllergic.toString()),
                              ),
                         
                            ],
                          ),

                          // Header row

                          // Data rows
                          /*
                          ...categories.map((category) {
                            return Row(
                              children: [
                                Expanded(child: Text(category.name ?? '')),
                                Expanded(
                                  child: Text(
                                    category.createdAt?.toLocal().toIso8601String() ?? '',
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                          */
                        ],
                      ),
                      onTap: () {
                        // Handle category tap
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}