
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/professionnel_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/professionnel_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class AllProfessionnelWidget extends StatefulWidget {
  const AllProfessionnelWidget({super.key});

  @override
  State<StatefulWidget> createState() => AllProfessionnelWidgetState();
}

class AllProfessionnelWidgetState extends State<AllProfessionnelWidget> {
  List<ProfessionnelModel> professions = [];
  late ProfessionnelService professionnelService;

  @override
  void initState() {
    professionnelService = getIt<ProfessionnelService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allProfessionnels = await professionnelService.allModels();
    setState(() {
      professions = allProfessionnels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'All Professions')
          : AdminPanelAppBar(title: 'All Professions'),
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
                  'Telephone',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: professions.length,
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
                                child: Text(professions[index].name ?? ''),
                              ),
                              Expanded(
                                child: Text(                         
                                      professions[index].name?? '',                             
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  professions[index].name ?? '',
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
