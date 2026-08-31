import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dahsboard_page.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dash_board_side_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  late final DashboardService service;
  late final Future<DashboardModel> model;

  @override
  void initState() {
    super.initState();

    service = getIt<DashboardService>();
    model = service.loadDashboardItems(FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DashboardModel>(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final models = snapshot.data ?? DashboardModel.empty();
          return Row(
            children: [
              Responsive.isDesktop(context) ? SizedBox(height: MediaQuery.of(context).size.height, width: 400, child: Padding(
                padding: const EdgeInsets.all(WidgetConstants.sepWidget ),
                child: DashBoardSideMenu(),
              )) : SizedBox(),
              SizedBox(width: WidgetConstants.sepWidget,),
              Expanded(child: DahsboardPage(models: models, service: service)),
            ],
          );
        },
      ),
    );

    /*
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                       // CardsGrid(),
                     const  DahsboardPage(),
                        const ProductGridWidget(isMain: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    */
  }
}
