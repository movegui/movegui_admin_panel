
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class AllRestaurantsWidget extends StatefulWidget {
  const AllRestaurantsWidget({super.key});

  @override
  State<StatefulWidget> createState() => AllRestaurantsWidgetState();
}

class AllRestaurantsWidgetState extends State<AllRestaurantsWidget> {

   List<RestaurantModel> restaurants = [];
  late RestaurantsService restaurantService;

  @override
  void initState() {
    restaurantService =  getIt<RestaurantsService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allRestaurantsTypes = await restaurantService.allModels();
    setState(() {
      restaurants = allRestaurantsTypes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'All Restaurants')
          : AdminPanelAppBar(title: 'All Restaurants'),
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
                  'Adresse',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
                 Expanded(
                child: Text(
                  'Contact',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
                           Expanded(
                child: Text(
                  'Telephone',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: restaurants.length,
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
                                child: Text(restaurants[index].name ?? ''),
                              ),
                              Expanded(
                                child: Text(
                                  restaurants[index].adresse ?? '' ),
                              ),
                              /*
                                       Expanded(
                                child: Text(
                                  restaurants[index].contact ?? '' ),
                              ),
                              */
                                              Expanded(
                                child: Text(
                                  restaurants[index].telephon ?? '' ),
                              )
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
