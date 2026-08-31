/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/providers/providers.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';
import 'package:movegui_admin_panel/widgets/web/profile_menu_widget.dart';
import 'package:riverpod/src/framework.dart';

class AdminPanelAppBar extends ConsumerWidget implements PreferredSizeWidget {
  AdminPanelAppBar({super.key, required this.title});
  final String title;
  final userService = getIt<UserService>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final currentUser = ref.watch(userProviderState).user;
    return 
  }

  Widget showConnectionBtn(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
            onPressed: (item) async {
              context.push(RouteConstants.LOGIN_ROUTE);
            },
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.login_title,
              enabled: true,
            ),
            icon: Icon(Icons.login),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
            onPressed: (item) async {
              context.push(RouteConstants.REGISTER_ROUTE);
            },
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.label_registration,
              enabled: true,
            ),
            icon: Icon(Icons.person),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }


*/


    /*
    return AppBar(
      title: Center(child: Text(title)),
      titleTextStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
        fontSize: Responsive.isDesktop(context) ? 32 : 20,
        color: AppColors.onPrimary,
      ),
      leading: Responsive.isMobile(context)
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  //   color: AppColors.textColor,
                  tooltip: AppLocalizations.of(
                    context,
                  )!.navigation_menu_tooltip,
                  hoverColor: AppColors.selectionColor,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              },
            )
          : null,

      backgroundColor: Color(0xFF871A1C), // Customize color
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            context.go(RouteConstants.SEARCH_ROUTE);
          },
          color: AppColors.onPrimary,
        ),

        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            context.go(RouteConstants.NOTIFICATION_ROUTE);
          },
          color: AppColors.onPrimary,
        ),

        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: IconButton(
            icon: Icon(Icons.supervised_user_circle),
            color: AppColors.onPrimary,
            onPressed: () async {
              if (FirebaseAuth.instance.currentUser != null) {
                if (Responsive.isMobile(context)) {
                  context.go(RouteConstants.PROFILE_ROUTE);
                } else {
                  await showMenu<String>(
                    context: context,
                    position: const RelativeRect.fromLTRB(100, 80, 0, 0),
                    items: [
                      PopupMenuItem(
                        value: '1',
                        child: MenuTile(
                          icon: Icons.logout,
                          title: AppLocalizations.of(
                            context,
                          )!.profile_menu_logout,
                          onTap: () async {
                            await userService.signOut(ref);
                            context.go(RouteConstants.LOGIN_ROUTE);
                          },
                          enabled: true,
                          routeName: RouteConstants.LOGIN_ROUTE,
                        ), //MoveguiProfileScreen(),
                      ),
                    ],
                  );
                }
              } else {
                await showMenu<String>(
                  context: context,
                  position: const RelativeRect.fromLTRB(100, 60, 0, 10),
                  items: [
                    PopupMenuItem(
                      value: '1',
                      child: MenuTile(
                        icon: Icons.login,
                        title: AppLocalizations.of(context)!.profile_menu_login,
                        onTap: () => context.go(RouteConstants.LOGIN_ROUTE),
                        enabled: true,
                        routeName: RouteConstants.LOGIN_ROUTE,
                      ),
                    ),
                    const PopupMenuItem(value: '2', child: Text('Item 2')),
                  ],
                );
              }

              //        context.go(RouteConstants.PROFILE_ROUTE);
            },
          ),
        ),
      ],
    );
  }
  *//*

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


*/
  /**
   * import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/app_constants.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/widgets/app/app_search_widget.dart';
import 'package:shom_gn/widgets/util/button_widget.dart';
import 'package:shom_gn/widgets/web/profile_menu_widget.dart';

class WebAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  WebAppBar({super.key, required this.title});
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final currentUser = ref.watch(userProviderState).user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              onPressed: (item) async {
                context.push(RouteConstants.HOME_ROUTE);
              },
              buttonItem: ButtonInfo(title: AppConstants.name, enabled: true),
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/icons/shom-logo.jpg',
                  width: 24,
                  height: 24,
                ),
              ),
              textStyle: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          const SizedBox(width: WidgetConstants.sepWidgetWidth),
          const Icon(Icons.location_on),
          //   CurrentPositionWidget(),
          const SizedBox(width: WidgetConstants.sepWidgetWidth),

          Expanded(
            child: AppSearchWidget(
              controller: controller,
              focusNode: focusNode,
            ),
          ),

          const SizedBox(width: WidgetConstants.sepWidgetWidth),
          if (user != null)
            ProfileMenuWidget(user: currentUser)
          else
            showConnectionBtn(context),
        ],
      ),
    );
  }

  Widget showConnectionBtn(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
            onPressed: (item) async {
              context.push(RouteConstants.LOGIN_ROUTE);
            },
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.label_login_web,
              enabled: true,
            ),
            icon: Icon(Icons.login),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
            onPressed: (item) async {
              context.push(RouteConstants.REGISTER_ROUTE);
            },
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.label_registration,
              enabled: true,
            ),
            icon: Icon(Icons.person),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}

   */
//}
