import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/categories/add_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/categories/all_categories_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';

import '../inter_screen/product_upload.dart';
import '../responsive.dart';
import 'dashboard_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.pageScreen});
  final Widget pageScreen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const SideMenu(),
        body: Builder(
          builder: (context) => SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  const Expanded(child: SideMenu()),
                Expanded(flex: 5, child: pageScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'Categories')
          : AdminPanelAppBar(title: 'Categories'),
      drawer: SideMenu(),
      body: Column(
        children: [
          Row(
            children: [
              CustomButon(
                text: 'Add New',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(pageScreen: AllCategoriesWidgetPage()),
                    ),
                  );
                },
                icon: Icons.add,
              ),

                const Spacer(),

              CustomButon(
                text: 'View All',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(pageScreen: CategoryAddWidgetPage()),
                    ),
                  );
                },
                icon: Icons.list_alt,
              ),
        
            ],
          ),
        ],
      ),
    );
  }
}
