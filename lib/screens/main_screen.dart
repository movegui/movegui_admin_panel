import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import '../responsive.dart';

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

abstract class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.addModelWidget, required this.allModelWidget, required this.title});
  final Widget addModelWidget, allModelWidget;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: title)
          : AdminPanelAppBar(title: title),
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
                          MainScreen(pageScreen: addModelWidget),
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
                          MainScreen(pageScreen: allModelWidget),
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
