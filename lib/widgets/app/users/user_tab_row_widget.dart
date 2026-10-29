import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/action_tab_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/status_widget.dart';

class UserTabRowWidget extends StatelessWidget {
  final UserModel user;
  final ValueChanged<UserModel> onEdit;
  final ValueChanged<UserModel> onDelete;
  final ValueChanged<UserModel> onChangeStatus;

  const UserTabRowWidget({
    super.key,
    required this.user,
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
                  text: '${user.personModel?.name}',
                  textAlign: TextAlign.left,
                ),
              ),

              Expanded(
                flex: 3,
                child: DisplayWidget(text: user.personModel?.email ?? ''),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(text: user.personModel?.phone ?? ''),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(text: user.role.name ?? ''),
              ),

              Expanded(
                flex: 2,
                child: StatusWidget(
                  isActive: user.isActive ?? false,
                  icon: Icons.dry_cleaning_rounded,
                ),
              ),

              Expanded(
                flex: 2,
                child: ActionTabWidget<UserModel>(
                  model: user,
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
                  text: user.personModel?.name ?? '',
                  textAlign: TextAlign.left,
                ),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(text: user.personModel?.email ?? ''),
              ),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: user.personModel?.phone ?? '',
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
