import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/dashbord_panel.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/empty_stat_panel.dart';

class RecentActivitiesPanel extends StatelessWidget {
  final FirebaseFirestore firestore;

  const RecentActivitiesPanel({super.key, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return DashboardPanel(
      title: 'Activités récentes',
      icon: Icons.history_rounded,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection(MoveGuiCollections.COLLECTION_PRESSINGS)
            .orderBy('createdAt', descending: true)
            .limit(8)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const EmptyStatePanel(
              icon: Icons.inbox_rounded,
              title: 'Aucune activité récente',
              subtitle: 'Les nouvelles actions apparaîtront ici.',
            );
          }

          return Column(
            children: docs.map((doc) {
              final data = doc.data();
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                //  backgroundColor: AppColors.error.withOpacity(0.1),
                  child: const Icon(Icons.check_circle,),
                ),
                title: Text(
                  (data['title'] ?? 'Activité MoveGui').toString(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text((data['description'] ?? '').toString()),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}