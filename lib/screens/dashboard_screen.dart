import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/constants.dart';
import '../widgets/app/dashboard/cards_grid.dart';
import '../widgets/grid_products.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});


  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CardsGrid(),
                        const ProductGridWidget(isMain: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
