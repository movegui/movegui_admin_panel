

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/action_tab_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/status_widget.dart';

class PressingServiceTabRowWidget extends StatelessWidget {
  final PressingServiceModel service;
  final ValueChanged<PressingServiceModel> onEdit;
  final ValueChanged<PressingServiceModel> onDelete;
  final ValueChanged<PressingServiceModel> onChangeStatus;

  const PressingServiceTabRowWidget({
    super.key,
    required this.service,
    required this.onEdit,
    required this.onDelete,
    required this.onChangeStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.12)),
        ),
      ),
      child: Responsive.isDesktop(context)
          ? buildDesktop(context)
          : buildMobile(context),
    );
  }

  Widget buildDesktop(BuildContext context) {
    return Row(
      children: [
        // SERVICE
        Expanded(
          flex: 12,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: DisplayWidget(
                  text: service.product.name ?? '',
                  textAlign: TextAlign.left,
                ),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: service.basePrice?.toString() ?? '0.0',
                ),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: service.serviceType.pricingType?.name ?? '',
                ),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: service.estimatedDuration?.inHours.toString() ?? '0',
                ),
              ),

              Expanded(
                flex: 2,
                child: StatusWidget(
                  isActive: service.isActive ?? false,
                  icon: Icons.dry_cleaning_rounded,
                ),
              ),

              Expanded(
                flex: 2,
                child: ActionTabWidget<PressingServiceModel>(
                  model: service,
                  onEdit: onEdit,
                  onDelete: onDelete,
                  onChangeStatus: onChangeStatus,
                ),
              ),
            ],
          ),
        ),

        // PRIX
      ],
    );
  }

  Widget buildMobile(BuildContext context) {
    return Row(
      children: [
        // SERVICE
        Expanded(
          flex: 12,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: DisplayWidget(
                  text: service.product.name ?? '',
                  textAlign: TextAlign.left,
                ),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: service.basePrice?.toString() ?? '0.0',
                ),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: service.isActive == true ? ' Actif ' : 'Désactif',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),

        // PRIX
      ],
    );
  }
}
