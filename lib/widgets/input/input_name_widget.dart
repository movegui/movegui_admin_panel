import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';

class InputNameWidget extends StatelessWidget {
  final TextEditingController nameController;
  final FocusNode nameFocusNode;
  final FocusNode? nextFocusNode;
  final String? hinterText;
  final String? labelText;
  final IconData? icon;

  const InputNameWidget({
    super.key,
    required this.nameController,
    required this.nameFocusNode,
    this.nextFocusNode,
    required this.hinterText,
    this.labelText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return InputWidget(
      controller: nameController,
      focusNode: nameFocusNode,
      prefixIcon: Icon(icon) ?? Icon(Icons.person),
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.name,
      hintText: hinterText ?? '',
      labelText: labelText ?? '',
      validator: (value) {
        return MyValidators.textNameValidator(value);
      },
      onChange: (String value) {},
    //  isNumber: false,
       isFullBorder: true,
    );
  }
}
