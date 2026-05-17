import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/supplier_model.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/suppliers_service.dart';


/*
class AllSuppliersWidget extends MainScreen {
  const AllSuppliersWidget({super.key, required super.pageScreen});
  
}
*/

class AllSuppliersWidgetPage extends StatefulWidget {
  const AllSuppliersWidgetPage({super.key});

  @override
  State<AllSuppliersWidgetPage> createState() => AllSuppliersWidgetState();
}

class AllSuppliersWidgetState extends State<AllSuppliersWidgetPage> {
  List<SupplierModel> suppliers = [];
  late SuppliersService suppliersService;

  @override
  void initState() {
    suppliersService = getIt<SuppliersService>(); //SuppliersService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allsuppliers = await suppliersService.allModels();
    setState(() {
      suppliers = allsuppliers;
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
                  'Company',
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
                   Expanded(
                child: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: suppliers.length,
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
                                child: Text(suppliers[index].name),
                              ),
                              /*
                                      Expanded(
                                child: Text(suppliers[index].company),
                              ),
                              */
                                      Expanded(
                                child: Text(suppliers[index].address.address),
                              ),
                                      Expanded(
                                child: Text(suppliers[index].telephon),
                              ),
                                      Expanded(
                                child: Text(suppliers[index].email),
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
