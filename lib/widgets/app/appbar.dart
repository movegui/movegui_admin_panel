import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/screens/admin_screen.dart';
import 'package:movegui_admin_panel/screens/notification_screen.dart';
import 'package:movegui_admin_panel/screens/search_screen.dart';


class AdminPanelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminPanelAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF), // Set the title color
        fontSize: 20,
      ),
      
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu),
            color: Color(0xFFFFFFFF),
            tooltip: 'Navigation menu',
            onPressed: () {
              //  _showMenu(context);
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      
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
