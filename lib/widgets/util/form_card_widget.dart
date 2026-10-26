import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';

class FormCardWidget extends StatelessWidget {
  final Widget child;
  final ShapeBorder? shape;
  final Color? color;
  const FormCardWidget({super.key, required this.child, this.shape, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
      child: Padding(padding: const EdgeInsets.all(WidgetConstants.sepWidget), child: child),
    );
  }
}
