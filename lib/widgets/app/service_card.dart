import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String? subtitleText;
  final IconData icon;
  final int? count;
  final Color color;
  final VoidCallback onPress;
  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
     this.count,
    required this.color,
    this.subtitleText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color),
          ),
          title: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: color),
          ),
          subtitle: subtitleText != null
              ? Text(
                  "$subtitleText",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: color),
                )
              : Text(
                  "$count $title",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: color),
                ),
          onTap: onPress,
          hoverColor: AppColors.selectionColor,
        ),
      ),
    );
  }

  Widget _addServiceCard() {
    return SizedBox(
      width: 220,
      child: Card(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: const SizedBox(
            height: 80,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline),
                  SizedBox(width: 8),
                  Text("Ajouter un service"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
