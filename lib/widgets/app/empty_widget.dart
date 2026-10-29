import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/responsive.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const EmptyWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final styleText = Responsive.isDesktop(context)
        ? Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20)
        : Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon ?? Icons.local_laundry_service_outlined,
                  size: 28,
                  color: Theme.of(context).primaryColor.withValues(alpha: .25),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: styleText?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),
          Text(subtitle, style: styleText),
        ],
      ),
    );
  }

  /*

    Widget _buildEmptyState() {
    final styleText = Responsive.isDesktop(context)
        ? Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20)
        : Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_laundry_service_outlined,
            size: 64,
            color: Theme.of(context).primaryColor.withValues(alpha: .25),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.pressing_service_empty_title,
            style: styleText?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context)!.pressing_service_empty_subtitle,
            style: styleText,
          ),
        ],
      ),
    );
  }
  */
}
