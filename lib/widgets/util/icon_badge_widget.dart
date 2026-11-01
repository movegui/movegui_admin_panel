import 'package:flutter/material.dart';

class IconBadgeWidget extends StatelessWidget {
  const IconBadgeWidget({
    super.key,
    required this.icon,
    this.color,
    this.surface,
    this.size,
  });

  final IconData icon;
  final Color? color;
  final double? surface;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: surface ?? 52,
      height: surface ?? 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.13) ?? Theme.of(context).primaryColor.withValues(alpha: 0.13),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: size ?? 27),
    );
  }
}
