import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';

class SectionContainerWidget extends StatelessWidget {
  final Widget child;
  final Color? color;

  const SectionContainerWidget({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(WidgetConstants.sepWidget),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E7EF), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
