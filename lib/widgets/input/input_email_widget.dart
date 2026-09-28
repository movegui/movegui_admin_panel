import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';

class InputEmailWidget extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final FocusNode? nextFocusNode;
  final String? labelText;
    final EdgeInsetsGeometry? contentPadding;
      final FontWeight? fontweight;

  const InputEmailWidget({
    super.key,
    this.nextFocusNode,
    required this.emailController,
    required this.emailFocusNode,
    this.labelText,
    this.contentPadding,
    this.fontweight
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: emailController,
      focusNode: emailFocusNode,
      prefixIcon: Icon(Icons.mail),
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.emailAddress,
      hintText: AppLocalizations.of(context)!.input_hint_adress_email,
      labelText: labelText ?? '',
      validator: (value) {
        return MyValidators.emailValidator(value);
      },
      onChange: (String value) {},
  //    isNumber: false,
      isFullBorder: true,
      contentPadding: contentPadding,
      fontweight: fontweight,
    );
  }
}
