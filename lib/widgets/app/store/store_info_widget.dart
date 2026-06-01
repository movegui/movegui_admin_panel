import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

class StoreInfoWidget extends StatelessWidget {
  final StoreModel storeModel;
  final Color? backgroundColor;
  final Color? textColor;

  const StoreInfoWidget({
    super.key,
    required this.storeModel,
    this.backgroundColor = AppColors.backgroundColor,
    this.textColor = AppColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.location_on, color: textColor),
              title: Text(
                storeModel.address.address,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),

            ListTile(
              leading: Icon(Icons.phone, color: textColor),
              title: Text(
                storeModel.phone,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),

            ListTile(
              leading: Icon(Icons.email, color: textColor),
              title: Text(
                storeModel.email,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            /*
            ListTile(
              leading: const Icon(Icons.store),
              title: Text(storeModel.storeType!.name),
            ),
            */
          ],
        ),
      ),
    );
  }
}
