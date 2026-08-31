import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';

class ProfileMenuTitle extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback? onTap;
  final bool enabled;

  const ProfileMenuTitle({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: enabled
          ? IconTheme(
              data: IconThemeData(color: Theme.of(context).colorScheme.primary),
              child: icon,
            )
          : IconTheme(
              data: IconThemeData(color: AppColors.disabled),
              child: icon,
            ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: WidgetConstants.sepWidgetHeight * 2,
          fontWeight: FontWeight.bold,
          color: enabled
              ? Theme.of(context).colorScheme.primary
              : AppColors.disabled,
        ),
      ),
      onTap: onTap,
    );
  }
}
