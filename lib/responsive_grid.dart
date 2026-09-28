import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final bool? isVertical;


  const ResponsiveGrid({super.key, required this.children, this.isVertical = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int count = 1;
        if (isVertical == true) {
          count = Responsive.isDesktop(context) ? 1 : Responsive.isTablet(context) ? 1 : 1;
        } else {
          count = Responsive.isDesktop(context) ? 4 : Responsive.isTablet(context) ? 2 : 1;
        }
       
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: children.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            mainAxisExtent: 150,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: children[index],
          ),
        );
      },
    );
  }
}