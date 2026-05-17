import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class ValidationButton extends StatelessWidget {
  final Future<void> Function( ButtonItem item) fn;
  final ButtonItem buttonItem;
  final IconData? icon;

  const ValidationButton({
    super.key,
    required this.fn,
    required this.buttonItem,
    this.icon = IconlyLight.send,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Flexible(
          child: Center(
            child: SizedBox(
              width: Responsive.isMobile(context) ? size.width * 0.5 : 300,
              child: ButtonWidget(
                onPressed: fn,
                buttonItem: buttonItem,
                icon: icon,
                fontSize:
                    Responsive.isMobile(context)
                        ? WidgetConstants.buttonFonsize * 2
                        : WidgetConstants.buttonFonsize * 2.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
