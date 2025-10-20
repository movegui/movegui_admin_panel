
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';

class ProductScreen  extends StatelessWidget{
  const ProductScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Responsive.isDesktop(context) ? AdminPanelAppBarDesktop(title: 'Produits') : AdminPanelAppBar(title: 'Produits'),
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
                child: ProductPage(),
              ),
            ],
          ),
        ),
      )),
    );
  }
  
}

class ProductPage extends StatelessWidget {

  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('In Implementation..............'),
    );
  }
  
}