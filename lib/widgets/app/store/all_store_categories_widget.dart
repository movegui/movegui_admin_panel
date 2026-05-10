

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/store_categories_service.dart';

class AllStoreCatgoriesWidgetPage extends StatefulWidget {
  const AllStoreCatgoriesWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => AllStoreCategoriesWidgetState();
  
}



class AllStoreCategoriesWidgetState extends State<AllStoreCatgoriesWidgetPage> {
  List<CategoriesModel> categories = [];
  late StoreCategoriesService storeCategoriesService;

  @override
  void initState() {
    storeCategoriesService =  getIt<StoreCategoriesService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allStoresCategories = await storeCategoriesService.allModels();
    setState(() {
      categories = allStoresCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Created At',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.category),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(categories[index].name ?? ''),
                              ),
                              Expanded(
                                child: Text(
                                  categories[index].createdAt
                                          .toLocal()
                                          .toIso8601String() ??
                                      '',
                                ),
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
