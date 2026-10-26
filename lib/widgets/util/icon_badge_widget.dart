import 'package:flutter/material.dart';

class IconBadgeWidget extends StatelessWidget {
  const IconBadgeWidget({super.key, required this.icon, this.color});

  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.13) ?? Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 27),
    );
  }
}
