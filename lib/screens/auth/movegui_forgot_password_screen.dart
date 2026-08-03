import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/app/app_image.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/auth/login_forget_password_page.dart';


class MoveguiForgotPasswordScreen extends StatefulWidget {

  const MoveguiForgotPasswordScreen({super.key,});

  @override
  State<MoveguiForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<MoveguiForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgetPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }


    @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AdminPanelAppBar(title: AppLocalizations.of(context)!.forget_password_title),
        body: Responsive.isDesktop(context) ? buildDeskop() : buildMobil(),
        resizeToAvoidBottomInset: true,
    );
  }

  Widget buildMobil() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage(heightScale: 0.20,),
              SeparatorWidget(height: WidgetConstants.sepWidgetHeight,),
              LoginForgetPasswordPage(),
           
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDeskop() {
    return Center(
      child: SizedBox(
        width: 500,
        height: 500,
        /*
        decoration: BoxDecoration(
          color: AppColors.textColor,
          border: Border.all(color: AppColors.backgroundColor, width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}
