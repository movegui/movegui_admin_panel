import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/providers/providers.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/app_appbar.dart';
import 'package:movegui_admin_panel/widgets/app/app_image.dart';
import 'package:movegui_admin_panel/widgets/app/app_panel_mobile.dart';
import 'package:movegui_admin_panel/widgets/app/app_panel_web.dart';
import 'package:movegui_admin_panel/widgets/app/auth/login_email_page.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/widgets/web/web_appbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with RouteAware {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  int currentLoginScreen = 0;
  bool showFirst = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(appbarTitleProviderState)
          .setTitle(AppLocalizations.of(context)!.login_title);
    });
  }

  void updateState(int state) {
    setState(() {
      currentLoginScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  if (!mounted) return CircularProgressIndicator();
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? WebAppBar(title: AppLocalizations.of(context)!.login_title)
          : AppAppbar(
              itemCount: ref.watch(shoppingProviderState).itemCount,
              title: AppLocalizations.of(context)!.login_title,
            ),
      body: Responsive.isDesktop(context) ? buildDeskop() : buildMobil(),
      resizeToAvoidBottomInset: true,
    );
    //   );
  }

  Widget buildMobil() {
    return AppPanelMobile(
      childrens: [
        SeparatorWidget(),
         AppImage(heightScale: 0.20),
              SeparatorWidget(),
              LoginEmailPage(),
        /*
        PlatformWidget.isAndroid(context) ||
                PlatformWidget.isIos(context) ||
                PlatformWidget.isWeb(context)
            ? ToggleButtonExample(onStateChanged: updateState)
            : const SizedBox(),
        SizedBox(height: 6.0),
        currentLoginScreen == 0 ? LoginPhonePage() : LoginEmailPage(),
        */
      ],
    );
  }

  Widget buildDeskop() {
    return AppPanelWeb(
      childrens: [
        SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 1.5),
        LoginEmailPage()
      ],
      subtitle: 'Connectez-vous à votre compte',
      title: AppLocalizations.of(context)!.login_title,
    );
  }
}




/*
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
     //   appBar: AdminPanelAppBar(title: AppLocalizations.of(context)!.login_title),
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
      child: SizedBox(
        width: 700,
        height: 600,
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
              //  color: AppColors.backgroundColor,
                margin: EdgeInsets.only(left: 100, right: 100),
                child: Padding(
                  padding: const EdgeInsets.only(left: 90, right: 80),
                  child: SubtitleTextWidget(
                    label: AppLocalizations.of(context)!.login_title,
                    fontSize: WidgetConstants.subTitleFontSize * 3,
                //    color: AppColors.textColor,
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
*/