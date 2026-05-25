import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';

class InputNameWidget extends StatelessWidget {
  final TextEditingController nameController;
  final FocusNode nameFocusNode;
  final FocusNode? nextFocusNode;
  final String? hinterText;
  final Color? textColor;

  const InputNameWidget({
    super.key,
    required this.nameController,
    required this.nameFocusNode,
    this.nextFocusNode,
    required this.hinterText, 
    this.textColor = AppColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: nameController,
      focusNode: nameFocusNode,
      icon: Icons.person,
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.name,
      hinterText: hinterText!,
      textColor: textColor,
      validator: (value) {
        return MyValidators.textNameValidator(value);
      },
    );
  }
}
