import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/util/input_widget.dart';


class InputEmailWidget extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final FocusNode? nextFocusNode;

  InputEmailWidget({
    super.key,
    this.nextFocusNode,
    required this.emailController,
    required this.emailFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: emailController,
      focusNode: emailFocusNode,
      icon: IconlyLight.message,
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.emailAddress,
      hinterText: AppLocalizations.of(context)!.input_hint_adress_email,
      validator: (value) {
        return MyValidators.emailValidator(value);
      },
    );
  }
}
