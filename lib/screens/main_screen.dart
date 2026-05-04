import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/screens/auth/login_screen.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';
import '../responsive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.pageScreen});
  final Widget pageScreen;

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  UserModel? currentUser;
  late UserService userService;

  @override
  void initState() {
    userService = getIt<UserService>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        if (AppLocalizations.of(context) != null) {
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.dashbord_title,
          );
          final user = await userService.getCurrentUser();
          setState(() {
            currentUser = user;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminPanelAppBar(
        title: context.watch<AppbarTitleProvider>().title,
      ),
      drawer: Responsive.isMobile(context) ? SideMenu() : null,
      body: (currentUser != null && currentUser!.role == UserRole.Admin)
          ? Builder(
              builder: (context) => SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // We want this side menu only for large screen
                    if (Responsive.isDesktop(context))
                      const Expanded(child: SideMenu()),
                    Expanded(flex: 5, child: widget.pageScreen),
                  ],
                ),
              ),
            )
          : LoginScreen(),
    );
  }
}

/*
    return  SafeArea(
      child: Scaffold(
        drawer: const SideMenu(),
        body: Builder(
          builder: (context) => SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  const Expanded(child: SideMenu()),
                Expanded(flex: 5, child: pageScreen),
              ],
            ),
          ),
        ),
      ),
    );
    */

abstract class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.addModelWidget,
    required this.allModelWidget,
    required this.title,
  });
  final Widget addModelWidget, allModelWidget;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminPanelAppBar(title: title),
      drawer: SideMenu(),
      body: Column(
        children: [
          Row(
            children: [
              CustomButon(
                text: 'Add New',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(pageScreen: addModelWidget),
                    ),
                  );
                },
                icon: Icons.add,
              ),

              const Spacer(),

              CustomButon(
                text: 'View All',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(pageScreen: allModelWidget),
                    ),
                  );
                },
                icon: Icons.list_alt,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
