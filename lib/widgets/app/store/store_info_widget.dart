import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

class StoreInfoWidget extends StatelessWidget {
  final StoreModel storeModel;

  const StoreInfoWidget({super.key, required this.storeModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(storeModel.address.address),
            ),

            ListTile(leading: Icon(Icons.phone), title: Text(storeModel.phone)),

            ListTile(leading: Icon(Icons.email), title: Text(storeModel.email)),
          ],
        ),
      ),
    );
  }
}
