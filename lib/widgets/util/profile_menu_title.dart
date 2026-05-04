import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/widget_constants.dart';

class ProfileMenuTitle extends StatelessWidget{

    final IconData icon;
    final String title;
    final VoidCallback? onTap;
    final bool enabled;

  const ProfileMenuTitle({super.key, required this.icon, required this.title, this.onTap, required this.enabled});
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: enabled ? Icon(icon, color: AppColors.backgroundColor) : Icon(icon, color: AppColors.placeHolderText),
      title: Text(
        title,
        style:  TextStyle(
          fontSize: WidgetConstants.sepWidgetHeight * 2,
          fontWeight: FontWeight.bold,
          color: enabled? AppColors.backgroundColor : AppColors.placeHolderText
        ),
      ),
      onTap: onTap,
    );
  }
  }
