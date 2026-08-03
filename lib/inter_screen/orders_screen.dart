import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/widgets/orders_grid.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dash_board_side_menu.dart';
import '../responsive.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DashBoardSideMenu(),
        body: Builder(
          builder: (context) => SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: DashBoardSideMenu(),
                  ),
                 Expanded(
                  flex: 5,
                  child: OrderGrid(isMain: false,),
                ),
              ],
            ),
          ),
        ));
  }
}
