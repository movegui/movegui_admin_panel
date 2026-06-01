import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';

class PressingServiceDetailsWidget extends StatelessWidget {
  final List<PressingServiceTypeModel> services;
  const PressingServiceDetailsWidget(this.services, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.store_services_title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: services.map((s) => Chip(label: Text(s.name))).toList(),
        ),
      ],
    );
  }
}
