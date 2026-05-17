import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/util/input_widget.dart';


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
      icon: Icons.home,
      nextFocusNode: nextFocusNode,
      textInputType: TextInputType.streetAddress,
      hinterText: AppLocalizations.of(context)!.input_hint_adress,
      textColor: AppColors.textColor,
      validator: (value) {
        return MyValidators.textNameValidator(value);
      },
    );
  }

}