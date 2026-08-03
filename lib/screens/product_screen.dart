
import 'package:flutter/material.dart';

class ProductScreen  extends StatelessWidget{
  const ProductScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

return Text('test');

    /*
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
    */
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