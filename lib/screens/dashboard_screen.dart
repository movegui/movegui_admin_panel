import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/dashboard/dashboard_model_data.dart';
import 'package:movegui_admin_panel/services/dashboard_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_page.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dash_board_side_menu.dart';
import 'package:movegui_admin_panel/widgets/web/main_page.dart';

class DashboardScreen extends StatefulWidget {
  final Widget Function(DashboardModelData models, DashboardService service)? pageBuilder;

  const DashboardScreen({super.key, this.pageBuilder});

  @override
  State<StatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  late final DashboardService service;
  late final Future<DashboardModelData> stats;

  @override
  void initState() {
    super.initState();

    service = getIt<DashboardService>();
    stats = service.loadDashboardItems(FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DashboardModelData>(
        future: stats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final stats = snapshot.data ?? DashboardModelData.empty();
          return MainPage(
            sideWidget: DashBoardSideMenu(),
            mainWidget: widget.pageBuilder?.call(stats, service) ??
                DashboardPage(stats: stats, service: service),
          );
        },
      ),
    );
  }
}
