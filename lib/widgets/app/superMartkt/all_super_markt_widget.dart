
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/super_markt_model.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/super_markts_service.dart';

class AllSuperMarktWidget extends StatefulWidget{
  const AllSuperMarktWidget({super.key});

  @override
  State<StatefulWidget> createState() => AllSuperMarktWidgetState();
}


class AllSuperMarktWidgetState extends State<AllSuperMarktWidget>{

 List<SuperMarktModel> superMarkts = [];
  late SuperMarktsService superMarktsService;

  @override
  void initState() {
    superMarktsService = getIt<SuperMarktsService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allSuperMarkts = await superMarktsService.allModels();
    setState(() {
      superMarkts = allSuperMarkts;
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
              itemCount: superMarkts.length,
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
                                child: Text(superMarkts[index].name),
                              ),
                              Expanded(
                                child: Text(superMarkts[index].address.address),
                              ),
                              /*
                              Expanded(
                                child: Text(superMarkts[index].contact),
                              ),
                              */
                              Expanded(
                                child: Text(superMarkts[index].telephon),
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