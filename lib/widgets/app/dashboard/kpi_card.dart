import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/dashboard/module_item.dart';

class KpiCard extends StatelessWidget {
  final ModuleItem item;

  const KpiCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 46,
                  height: 46,
                  child: Icon(item.icon, size: 26),
                ),
                const Spacer(),
                Text(
                  item.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Icon(Icons.trending_up_rounded),
              ],
            ),
            const Spacer(),
            const SizedBox(height: 6),
            Text(
              item.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(item.subtitle, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
