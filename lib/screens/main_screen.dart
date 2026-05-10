import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
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
  bool isAuthorize = false;

  @override
  void initState() {
    userService = getIt<UserService>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        if (AppLocalizations.of(context) != null) {
          final user = await userService.getCurrentUser();
          final autorization = await userService.isAuthorize(user);
          setState(() {
            currentUser = user;
            isAuthorize = autorization;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AdminPanelAppBar(title: AppLocalizations.of(context)!.dashbord_title),
      body: (currentUser != null && isAuthorize)
          ? Builder(
              builder: (context) => SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Responsive.isDesktop(context))
                      const Expanded(child: SideMenu()),
                    Expanded(flex: 5, child: widget.pageScreen),
                  ],
                ),
              ),
            )
          : Text('No Authorization !!!'),
    );
  }
}


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
