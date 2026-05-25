import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/auth/auth_link_widget.dart';
import 'package:movegui_admin_panel/widgets/app/auth/validation_button.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_email_widget.dart';
import 'package:movegui_admin_panel/widgets/input/password_widget.dart';

class LoginEmailPage extends ConsumerStatefulWidget {
  const LoginEmailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginEmailPageState();
}

class LoginEmailPageState extends ConsumerState<LoginEmailPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;

  bool isloading = false;
  FirebaseAuth? auth;
  late UserService userService;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    try {
      auth = FirebaseAuth.instance;
      userService = getIt<UserService>();
    } catch (e) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: AppLocalizations.of(
          context,
        )!.error_firebase_initialisation.toString(),
        fct: () {},
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct(ButtonItem item) async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid && item.enabled) {
      try {
        setState(() {
          isloading = true;
        });

        final userCredential = await auth?.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (userCredential?.user != null) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.success_login_message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
      
          await userService.getCurrentUserByMail(
            _emailController.text.trim(), ref
          );
          if (!mounted) return;
          context.go(item.routeName!);
        } else {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.error_login_message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } on FirebaseAuthException {
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: AppLocalizations.of(context)!.exception_login_message,
          fct: () {},
        );
      } finally {
        isloading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputEmailWidget(
                  nextFocusNode: _passwordFocusNode,
                  emailController: _emailController,
                  emailFocusNode: _emailFocusNode,
                  textColor: AppColors.backgroundColor,
                ),
                //  SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 2),
                PasswordWidget(
                  passwordController: _passwordController,
                  passwordFocusNode: _passwordFocusNode,
                  obscureText: obscureText,
                  onPressObscur: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  textColor: AppColors.backgroundColor,
                ),
                Responsive.isDesktop(context)
                    ? SeparatorWidget(height: 20)
                    : SizedBox(),
                AuthLinkWidget(),
                Responsive.isDesktop(context)
                    ? SeparatorWidget(height: 20)
                    : SizedBox(),

                Padding(
                  padding: const EdgeInsets.only(
                    left: WidgetConstants.sepWidgetHeight,
                    right: WidgetConstants.sepWidgetHeight,
                  ),
                  child: ValidationButton(
                    fn: _loginFct,
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.label_login,
                      tooltipText:  AppLocalizations.of(context)!.tooltip_sign_in,
                       enabled: true,
                      routeName: RouteConstants.HOME_ROUTE, onPress: () {  },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
