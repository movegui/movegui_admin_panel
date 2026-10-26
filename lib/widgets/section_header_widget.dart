import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/widgets/util/icon_badge_widget.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconColor,
    this.color,
    this.titleFontsize,
    this.subtitleFontsize,
  });
  final String title;
  final String subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? color;
  final double? titleFontsize;
  final double? subtitleFontsize;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).cardColor,
      child: Row(
        children: [
          IconBadgeWidget(
            icon: icon ?? Icons.warning_amber_rounded,
            color: iconColor ?? const Color(0xFFF59E0B),
          ),
          SizedBox(width: WidgetConstants.sepWidget),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: titleFontsize ?? 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: WidgetConstants.sepWidget * 0.5),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: subtitleFontsize ?? 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
