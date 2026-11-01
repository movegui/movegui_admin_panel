import 'package:flutter/material.dart';

class MenuSectionTitle extends StatelessWidget{
  const MenuSectionTitle({super.key, required this.title, this.fontsize, this.color});
  final String title;
  final double? fontsize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: color ?? const Color(0xFFE8BFC1),
            fontSize: fontsize ?? 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
  
}