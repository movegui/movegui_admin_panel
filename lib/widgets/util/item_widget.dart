import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/widgets/util/icon_badge_widget.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.color,
    this.surface,
    this.size,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? color;
  final double? surface;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(WidgetConstants.sepWidget),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Color(0xFF9AA5B5),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: WidgetConstants.sepWidget),
          Row(
            children: [
              IconBadgeWidget(
                icon: icon ?? Icons.abc,
                color: color,
                surface: surface,
                size: size,
              ),
              SizedBox(width: WidgetConstants.sepWidget),
              Expanded(
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF263445),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
