import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/auth/register_email_page.dart';
import 'package:movegui_admin_panel/widgets/subtitle_text.dart';

class RegisterScreen extends ConsumerWidget {
  final UserRole role;
  final String title;
  const RegisterScreen({super.key, required this.role, required this.title,});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive.isDesktop(context) ? buildDesktop(context) : buildMobil(context),
    );
  }

  Widget buildMobil(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
          //  AppImage(heightScale: 0.10),
            SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 2,),
            RegisterEmailPage(role: role,),
          ],
        ),
      ),
    );
  }

  Widget buildDesktop(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 700,
           // height: size.height * 0.9,
            decoration: BoxDecoration(
              color: AppColors.textColor,
              border: Border.all(color: AppColors.backgroundColor, width: 10),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColors.backgroundColor,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35, right: 30),
                      child: SubtitleTextWidget(
                        label: title,
                        fontSize: WidgetConstants.subTitleFontSize * 2,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  SeparatorWidget(height: 30),
                  RegisterEmailPage(role: role,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
