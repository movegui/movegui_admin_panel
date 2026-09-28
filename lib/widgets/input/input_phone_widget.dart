import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';

class InputPhoneWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final FocusNode? nextFocusNode;
  final double? fontSize;
  final String? labelText;

  const InputPhoneWidget({
    super.key,
    required this.phoneController,
    required this.phoneFocusNode,
    this.nextFocusNode,
    this.fontSize,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: phoneController,
      focusNode: phoneFocusNode,
      prefixIcon:Icon(Icons.phone),
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.phone,
      hintText: '+224 601 00 00 00',
      validator: (value) {
        return MyValidators.phoneNumberValidator(value);
      },
      fontSize: fontSize ?? 14,
      labelText: labelText ?? '',
      onChange: (String value) {},
  //    isNumber: false,
      isFullBorder: true,
    );
  }
}
