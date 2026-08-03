import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/app/main/main_page_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dash_board_side_menu.dart';
import '../responsive.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key, required this.pageScreen});
  final Widget pageScreen;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  UserModel? currentUser;
  late UserService userService;
  bool isAuthorize = false;

  @override
  void initState() {
    userService = getIt<UserService>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        if (AppLocalizations.of(context) != null) {
          final user = await userService.getCurrentUser(context, ref);
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
      appBar: AdminPanelAppBar(
        title: Responsive.isDesktop(context)
            ? AppLocalizations.of(context)!.movegui_panel
            : AppLocalizations.of(context)!.movegui_panel_mobile,
      ),
      drawer: Responsive.isMobile(context) ? DashBoardSideMenu() : null,
      body: (currentUser != null && isAuthorize)
          ? Builder(
              builder: (context) => SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Responsive.isDesktop(context))
                      Expanded(child: DashBoardSideMenu()),
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
  });
  final MainPageWidget addModelWidget, allModelWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              CustomButon(
                text: addModelWidget.buttonItem.title,
                onTap: () {
                //  addModelWidget.buttonItem.onPress();
                },
                icon: Icons.add,
              ),

              const Spacer(),

              CustomButon(
                text: allModelWidget.buttonItem.title,
                onTap: () {
                //  allModelWidget.buttonItem.onPress();
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
