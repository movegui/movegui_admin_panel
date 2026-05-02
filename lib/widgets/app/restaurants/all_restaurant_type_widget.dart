
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class AllRestaurantTypeWidgetPage extends StatefulWidget {
  const AllRestaurantTypeWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => AllRestaurantsTypeWidgetState();
  
}



class AllRestaurantsTypeWidgetState extends State<AllRestaurantTypeWidgetPage> {
  List<RestaurantTypeModel> restaurantTypes = [];
  late RestaurantTypeService restaurantTypeService;

  @override
  void initState() {
    restaurantTypeService =  getIt<RestaurantTypeService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allRestaurantsTypes = await restaurantTypeService.allModels();
    setState(() {
      restaurantTypes = allRestaurantsTypes;
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
              itemCount: restaurantTypes.length,
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
                                child: Text(restaurantTypes[index].name ?? ''),
                              ),
                              Expanded(
                                child: Text(
                                  restaurantTypes[index].createdAt
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
