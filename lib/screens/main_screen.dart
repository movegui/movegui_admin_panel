import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/providers.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/app/app_appbar.dart';
import 'package:movegui_admin_panel/widgets/app/main/main_page_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dash_board_side_menu.dart';
import 'package:movegui_admin_panel/widgets/web/web_appbar.dart';
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
      appBar: Responsive.isDesktop(context)
          ? WebAppBar(title: AppLocalizations.of(context)!.movegui_panel)
          : AppAppbar(
              itemCount: ref.watch(shoppingProviderState).itemCount,
              title: AppLocalizations.of(context)!.movegui_panel_mobile,
            ),

      drawer: Responsive.isMobile(context) ? DashBoardSideMenu() : null,
      body: (currentUser != null && isAuthorize)
          ? Builder(builder: (context) => SafeArea(child: widget.pageScreen))
          : Center(
              child: Text(
                'No Authorization !!!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
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
                onTap: () {},
                icon: Icons.add,
              ),

              const Spacer(),

              CustomButon(
                text: allModelWidget.buttonItem.title,
                onTap: () {},
                icon: Icons.list_alt,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
