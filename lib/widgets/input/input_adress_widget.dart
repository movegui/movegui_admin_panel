import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';


class InputAdressWidget extends StatelessWidget {

  final TextEditingController adressController;
  final FocusNode adressFocusNode;
  final FocusNode? nextFocusNode;

  const InputAdressWidget({
    super.key,
    required this.adressController,
    required this.adressFocusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      controller: adressController,
      focusNode: adressFocusNode,
      prefixIcon: Icon(Icons.home),
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.streetAddress,
      hintText: AppLocalizations.of(context)!.input_hint_adress,
      validator: (value) {
        return MyValidators.textNameValidator(value);
      },
    );
  }

}