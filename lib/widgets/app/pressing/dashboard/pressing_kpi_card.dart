import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/kpi_card.dart';
import 'package:movegui_admin_panel/widgets/util/icon_badge_widget.dart';

class PressingKpiCard extends KpiCard {
  const PressingKpiCard({super.key, required super.item});

  @override
  Widget build(BuildContext context) {
    /*
    return _DashboardSurface(
      padding: const EdgeInsets.all(18),
      child: 
      */

    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            IconBadgeWidget(
              icon: item.icon,
              color: item.color ?? Theme.of(context).primaryColor.withValues(alpha: 0.13),
           //   iconColor: item.color,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF572126),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.value,
                    style: const TextStyle(
                      color: Color(0xFF172554),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.description ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF645A7D),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
          //    ),
        ),
      ),
    );
  }
}
