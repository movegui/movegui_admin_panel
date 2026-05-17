import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';

class RepeatPasswordWidget extends StatefulWidget {
  final TextEditingController passwordController, repeatPasswordController;
  final FocusNode passwordFocusNode, repeatPasswordFocusNode;

  const RepeatPasswordWidget({
    super.key,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.passwordFocusNode,
    required this.repeatPasswordFocusNode,
  });
  @override
  State<StatefulWidget> createState() => RepeatPasswordWidgetState();
}

class RepeatPasswordWidgetState extends State<RepeatPasswordWidget> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.passwordController,
          focusNode: widget.passwordFocusNode,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: "***********",
            prefixIcon: const Icon(
              Icons.lock,
              color: AppColors.backgroundColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          onFieldSubmitted: (value) async {
            FocusScope.of(context).requestFocus(widget.repeatPasswordFocusNode);
          },
          validator: (value) {
            return MyValidators.passwordValidator(value);
          },
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.repeatPasswordController,
          focusNode: widget.repeatPasswordFocusNode,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: "Repeter Mot de pass",
            prefixIcon: const Icon(
              Icons.lock,
              color: AppColors.backgroundColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          onFieldSubmitted: (value) async {
            //  await _registerFCT();
          },
          validator: (value) {
            return MyValidators.repeatPasswordValidator(
              value: value,
              password: widget.passwordController.text,
            );
          },
        ),
      ],
    );
  }
}
