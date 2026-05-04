import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/widgets/app/main/add_model_btn_widget.dart';
import 'package:movegui_admin_panel/widgets/app/main/all_model_btn_widget.dart';

class PressingScreen extends MainScreen {
  const PressingScreen({super.key, required super.pageScreen});
}

class PressingPage extends MainPage {
  const PressingPage({
    super.key,
    required super.addModelWidget,
    required super.allModelWidget,
    required super.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AddModelBtnWidget(addModelWidget: addModelWidget),
            const Spacer(),
            AllModelBtnWidget(allModelWidget: allModelWidget),
          ],
        ),
      ],
    );
  }
}