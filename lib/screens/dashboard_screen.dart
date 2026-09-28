import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_page.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dash_board_side_menu.dart';
import 'package:movegui_admin_panel/widgets/web/main_page.dart';

class DashboardScreen extends StatefulWidget {
  final Widget Function(DashboardModel models, DashboardService service)? pageBuilder;

  const DashboardScreen({super.key, this.pageBuilder});

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
          return MainPage(
            sideWidget: DashBoardSideMenu(),
            mainWidget: widget.pageBuilder?.call(models, service) ??
                DashboardPage(models: models, service: service),
          );
        },
      ),
    );
  }
}
