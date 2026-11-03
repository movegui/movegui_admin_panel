import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/widgets/util/icon_badge_widget.dart';
import 'package:movegui_admin_panel/widgets/util/section_container_widget.dart';

class KpiCard extends StatelessWidget {
  final ModuleItem item;
  final bool? positive;

  const KpiCard({super.key, required this.item, this.positive = true});

  @override
  Widget build(BuildContext context) {
    return

    SectionContainerWidget(
      child: Row(
        children: [
          IconBadgeWidget(
            icon: item.icon,
            color:
                item.color ??
                Theme.of(context).primaryColor.withValues(alpha: 0.13),
            //   iconColor: item.color,
          ),
          const SizedBox(width: WidgetConstants.sepWidget),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF572126),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      positive == true
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      color: positive == true
                          ? AppColors.active
                          : AppColors.error,
                    ),
                  ],
                ),
                const SizedBox(height: 5),

                Text(
                  item.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  item.description ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: positive == true
                        ? AppColors.active
                        : AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //   ),
    );
  }
}
