import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class SupplierScreen extends MainScreen{
  const SupplierScreen({super.key, required super.pageScreen});

  
  /*
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  Responsive.isDesktop(context) ? AdminPanelAppBarDesktop(title: 'Fournisseurs') : AdminPanelAppBar(title: 'Fournisseurs'),
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
                child: SupplierPage(),
              ),
            ],
          ),
        ),
      )),
    );
  }
  */
  
}


class SupplierPage extends MainPage {

  const SupplierPage({super.key, required super.addModelWidget, required super.allModelWidget, required super.title});

  
}