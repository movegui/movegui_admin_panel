import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/responsive.dart';

class LayoutBuilderWidget extends StatelessWidget {
  final List<Widget> children;

  const LayoutBuilderWidget({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: WidgetConstants.sepWidget * 1.5,
        children: children.map((child) => Expanded(child: child)).toList(),
      );
    }

    return Column(
      spacing: WidgetConstants.sepWidget * 1.5 ,
      children: children,
    );
  }
}