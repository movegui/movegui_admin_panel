import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class RestaurantScreen extends StatelessWidget{
  const RestaurantScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  Responsive.isDesktop(context) ? AdminPanelAppBarDesktop(title: 'Restaurants') : AdminPanelAppBar(title: 'Restaurants'),
        drawer: const SideMenu(),
        body: Builder(
        builder: (context) => SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              const Expanded(
                flex: 5,
                child: RestaurantPage(),
              ),
            ],
          ),
        ),
      )),
    );
  }
  
}

class RestaurantPage extends StatelessWidget {

  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  appBar: AdminPanelAppBar(title: 'Restaurants'),
      body: Text('In Implementation..............'),
    );
  }
  
}


