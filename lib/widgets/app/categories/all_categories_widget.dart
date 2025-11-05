import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/categories_screen.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/services/categories_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';


/*
class AllCategoriesWidget extends MainScreen {
  const AllCategoriesWidget({super.key, required super.pageScreen});
}
*/

class AllCategoriesWidgetPage extends StatefulWidget {
  const AllCategoriesWidgetPage({super.key});

  @override
  State<AllCategoriesWidgetPage> createState() => AllCategoriesWidgetState();
}

class AllCategoriesWidgetState extends State<AllCategoriesWidgetPage> {
  List<CategoriesModel> categories = [];
  late CategoriesService categoriesService;

  @override
  void initState() {
    categoriesService =  getIt<CategoriesService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allcategories = await categoriesService.allModels();
    setState(() {
      categories = allcategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'All Categories')
          : AdminPanelAppBar(title: 'All Categories'),
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
                                          ?.toLocal()
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
