import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/config/env.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/main_dev.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/app/app_image.dart';
import 'package:movegui_admin_panel/widgets/app/auth/login_email_page.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/subtitle_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
        appBar: AdminPanelAppBar(title: AppLocalizations.of(context)!.login_title),
        body: Responsive.isDesktop(context) ? buildDeskop(context) : buildMobil(context),
        resizeToAvoidBottomInset: true,
      );
  }

  Widget buildMobil(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppImage(heightScale: 0.20),
              SeparatorWidget(),
              LoginEmailPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDeskop(BuildContext context) {
    return Center(
      child: Container(
        width: 700,
        height: 600,
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
                margin: EdgeInsets.only(left: 100, right: 100),
                child: Padding(
                  padding: const EdgeInsets.only(left: 90, right: 80),
                  child: SubtitleTextWidget(
                    label: AppLocalizations.of(context)!.login_title,
                    fontSize: WidgetConstants.subTitleFontSize * 3,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              SeparatorWidget(height: 30),
              LoginEmailPage(),
            ],
          ),
        ),
      ),
    );
  }
}
