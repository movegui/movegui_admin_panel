import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/patisserie_model.dart';
import 'package:movegui_admin_panel/services/patisseries_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';

class AllPatisserieWidget extends StatefulWidget {
  const AllPatisserieWidget({super.key});

  @override
  State<StatefulWidget> createState() => AllPatisserieWidgetState();
}

class AllPatisserieWidgetState extends State<AllPatisserieWidget> {
  List<PatisserieModel> patisseries = [];
  late PatisseriesService patisseriesService;

  @override
  void initState() {
    patisseriesService = getIt<PatisseriesService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allPatisseries = await patisseriesService.allModels();
    setState(() {
      patisseries = allPatisseries;
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
              itemCount: patisseries.length,
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
                                child: Text(patisseries[index].name ?? ''),
                              ),
                              Expanded(
                                child: Text(patisseries[index].adresse ?? ''),
                              ),
                              /*
                              Expanded(
                                child: Text(patisseries[index].contact ?? ''),
                              ),
                              */
                              Expanded(
                                child: Text(patisseries[index].telephon ?? ''),
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
