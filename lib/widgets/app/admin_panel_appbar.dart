import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/movegui_profile_screen.dart';
import 'package:movegui_admin_panel/util/profile_menu_title.dart';

class AdminPanelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminPanelAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(title)),
      titleTextStyle: TextStyle(
        color: AppColors.textColor, // Set the title color
        fontSize: 26,
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
                await showMenu<String>(
                  context: context,
                  position: const RelativeRect.fromLTRB(100, 80, 0, 0),
                  items: [
                    const PopupMenuItem(
                      value: '1',
                      child: MoveguiProfileScreen(),
                    ),
                  ],
                );
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
