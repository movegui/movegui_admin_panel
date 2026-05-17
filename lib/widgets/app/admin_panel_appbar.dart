import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/providers/current_user_provider.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/profile_menu_title.dart';

class AdminPanelAppBar extends ConsumerWidget implements PreferredSizeWidget {
  AdminPanelAppBar({super.key, required this.title});
  final String title;
  final userService = getIt<UserService>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(CurrentUserProvider.currentUserProvider).currentUser;
    return AppBar(
      title: Center(child: Text(title)),
      titleTextStyle: TextStyle(
        color: AppColors.textColor, // Set the title color
        fontSize: Responsive.isDesktop(context) ? 26 : 20,
      ),

      leading: Responsive.isMobile(context)
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  color: AppColors.textColor,
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
          color: AppColors.textColor,
          hoverColor: AppColors.selectionColor,
          onPressed: () {
            context.go(RouteConstants.SEARCH_ROUTE);
          },
        ),

        IconButton(
          icon: Icon(Icons.notifications),
          color: AppColors.textColor,
          hoverColor: AppColors.selectionColor,
          onPressed: () {
            context.go(RouteConstants.NOTIFICATION_ROUTE);
          },
        ),

        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: IconButton(
            icon: Icon(Icons.supervised_user_circle),
            color: AppColors.textColor,
            hoverColor: AppColors.selectionColor,
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
                        child: ProfileMenuTitle(
                          icon: Icons.logout,
                          title: AppLocalizations.of(
                            context,
                          )!.profile_menu_logout,
                          onTap: () async {
                            await userService.signOut(ref);
                            context.go(RouteConstants.LOGIN_ROUTE);
                            /*
                setState(() {
                  currentUser == null;
                });
                */
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
                      child: ProfileMenuTitle(
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

        /*
        IconButton(
          icon: Icon(Icons.search),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
        ),
                IconButton(
          icon: Icon(Icons.supervised_user_circle),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminScreen()),
            );
          },
        ),
        */
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

/*
class AdminPanelAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
  const AdminPanelAppBarDesktop({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF), // Set the title color
        fontSize: 20,
      ),

      leading: const SizedBox.shrink(),
      
      backgroundColor: Color(0xFF871A1C), // Customize color
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
        ),
                IconButton(
          icon: Icon(Icons.supervised_user_circle),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminScreen()),
            );
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
*/
