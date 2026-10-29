import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/responsive.dart';

class LayoutBuilderWidget extends StatelessWidget {
  final List<Widget> children;
  final bool? use2_1;

  const LayoutBuilderWidget({
    super.key,
    required this.children,
    this.use2_1 = false
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: WidgetConstants.sepWidget * 1.5,
        children: children.asMap().entries.map((entry) {
          return Expanded(
            flex: entry.key == 0 ?  use2_1 == true? 2 : 1 : 1,
            child: entry.value,
          );
        }).toList(),
      );
    }

    return Column(
      spacing: WidgetConstants.sepWidget * 1.5 ,
      children: use2_1 == true ? children.reversed.toList() : children,
    );
  }
}