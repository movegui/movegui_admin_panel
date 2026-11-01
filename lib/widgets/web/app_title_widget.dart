import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';

class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({super.key, required this.isCollapse});
  final bool isCollapse;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showTitle = constraints.maxWidth > 160 && !isCollapse;
        return Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/icons/movegui.jpg',
                  width: 37,
                  height: 37,
                ),
              ),
            ),
            if (showTitle) ...[
              SizedBox(width: WidgetConstants.sepWidget * 2),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Administration',
                      style: TextStyle(color: Color(0xFFE8BFC1), fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
