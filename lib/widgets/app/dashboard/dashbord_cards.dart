import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/widgets/util/section_container_widget.dart';

class DashBordCards extends ConsumerWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

  const DashBordCards({
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  return  SectionContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
           //     color: MoveGuiOverviewPage.burgundy,
                size: 21,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
