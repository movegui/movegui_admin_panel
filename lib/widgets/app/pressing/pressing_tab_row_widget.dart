import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/action_tab_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/status_widget.dart';

class PressingTabRowWidget extends StatelessWidget {
  final PressingModel pressing;
  final ValueChanged<PressingModel> onEdit;
  final ValueChanged<PressingModel> onDelete;
  final ValueChanged<PressingModel> onChangeStatus;

  const PressingTabRowWidget({
    super.key,
    required this.pressing,
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
          flex: 14,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: DisplayWidget(
                  text: pressing.name,
                  textAlign: TextAlign.left,
                ),
              ),

              Expanded(
                flex: 3,
                child: DisplayWidget(
                  text:
                      '${pressing.address.address} - ${pressing.address.adressType}',
                ),
              ),

              Expanded(flex: 2, child: DisplayWidget(text: pressing.phone)),

              Expanded(
                flex: 2,
                child: DisplayWidget(text: pressing.address.minucipality),
              ),

              Expanded(
                flex: 2,
                child: StatusWidget(
                  isActive: pressing.isActive ?? false,
                  icon: Icons.dry_cleaning_rounded,
                ),
              ),

              Expanded(
                flex: 2,
                child: ActionTabWidget<PressingModel>(
                  model: pressing,
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
          flex: 5,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: DisplayWidget(
                  text: pressing.name,
                  textAlign: TextAlign.left,
                ),
              ),

              Expanded(flex: 2, child: DisplayWidget(text: pressing.phone)),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: pressing.address.minucipality,
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
