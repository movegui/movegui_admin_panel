import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/app/app_image.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/auth/register_email_page.dart';
import 'package:movegui_admin_panel/widgets/subtitle_text.dart';

class MoveguiRegisterScreen extends StatefulWidget {
  const MoveguiRegisterScreen({super.key});

  @override
  State<MoveguiRegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<MoveguiRegisterScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  int currentLoginScreen = 0;
  bool showFirst = true;

  @override
  void initState() {
    super.initState();
  }

  void updateState(int state) {
    setState(() {
      currentLoginScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AdminPanelAppBar(
        title: AppLocalizations.of(context)!.register_title,
      ),
      body: Responsive.isDesktop(context) ? buildDesktop() : buildMobil(),
    );
  }

  Widget buildMobil() {
    var Size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppImage(heightScale: 0.10),
            SeparatorWidget(),
            RegisterEmailPage(role: UserRole.Guest,),
          ],
        ),
      ),
    );
  }

  Widget buildDesktop() {
    return Center(
      child: Container(
        width: 700,
        /*
        decoration: BoxDecoration(
          color: AppColors.textColor,
          border: Border.all(color: AppColors.backgroundColor, width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        */
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
            //    color: AppColors.backgroundColor,
                margin: EdgeInsets.only(left: 100, right: 100),
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 30),
                  child: SubtitleTextWidget(
                    label: AppLocalizations.of(context)!.register_title,
                    fontSize: WidgetConstants.subTitleFontSize * 3,
              //      color: AppColors.textColor,
                  ),
                ),
              ),
              SeparatorWidget(height: 30),
              Expanded(child: RegisterEmailPage(role: UserRole.Guest,)),
            ],
          ),
        ),
      ),
    );
  }
}
