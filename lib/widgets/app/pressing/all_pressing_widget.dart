
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/models/pressing_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class AllPressingWidgetPage extends StatefulWidget {
  const AllPressingWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => AllPressingWidgetPageState();
}

class AllPressingWidgetPageState extends State<AllPressingWidgetPage>{
 
  List<PressingModel> pressings = [];
  late PressingService pressingService;

  @override
  void initState() {
    pressingService = getIt<PressingService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allPressings = await pressingService.allModels();
    setState(() {
      pressings = allPressings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'All Pressings')
          : AdminPanelAppBar(title: 'All Pressings'),
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
              itemCount: pressings.length,
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
                                child: Text(pressings[index].name ?? ''),
                              ),
                              Expanded(
                                child: Text(pressings[index].adresse ?? ''),
                              ),
                              Expanded(
                                child: Text(pressings[index].contact ?? ''),
                              ),
                              Expanded(
                                child: Text(pressings[index].telephon ?? ''),
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