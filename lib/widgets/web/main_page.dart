import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/responsive.dart';

 class MainPage extends StatelessWidget {
  final Widget sideWidget;
  final Widget mainWidget;

  const MainPage({super.key, required this.sideWidget, required this.mainWidget});

  @override
  Widget build(BuildContext context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Responsive.isDesktop(context)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(
                          WidgetConstants.sepWidget ,
                        ),
                        child: sideWidget,
                      ),
                    )
                  : SizedBox(),
              SizedBox(width: WidgetConstants.sepWidget),
              Expanded(
                child: mainWidget,
              ),
            ],
          );
  }
}