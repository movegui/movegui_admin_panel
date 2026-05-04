import 'package:flutter/material.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/widgets/util/input_widget.dart';

class InputPhoneWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final FocusNode? nextFocusNode;
  final double? fontSize;
  final String? fontFamily;
  final Color? textColor;

  const InputPhoneWidget({
    super.key,
    required this.phoneController,
    required this.phoneFocusNode,
    this.nextFocusNode,
    this.fontSize,
    this.fontFamily,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: phoneController,
      focusNode: phoneFocusNode,
      icon: Icons.phone,
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.phone,
      hinterText: '+224 601 00 00 00',
      validator: (value) {
        return MyValidators.phoneNumberValidator(value);
      },
      fontSize: fontSize,
      fontFamily: fontFamily,
      textColor: textColor,
    );
  }
}
