import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;


  const ResponsiveGrid({super.key, required this.children,});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = Responsive.isDesktop(context) ? 4 : Responsive.isTablet(context) ? 2 : 1;  //(constraints.maxWidth / minItemWidth).floor().clamp(1, 4);
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
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}