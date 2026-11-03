import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';

class PanelItemWidget extends StatelessWidget {
  final ModuleItem moduleItem;

  const PanelItemWidget({
    super.key,
    required this.moduleItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: moduleItem.isActive == true ? moduleItem.color : AppColors.disabled, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              moduleItem.name,
              style:  TextStyle(fontWeight: FontWeight.w600, color: moduleItem.isActive == true ? Theme.of(context).colorScheme.primary : AppColors.disabled,),
            ),
          ),
          Text(
            moduleItem.value,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: moduleItem.isActive == true ? moduleItem.color : AppColors.disabled,
              fontSize: 18,
            ),
          ),
        ],
    );
  }
}