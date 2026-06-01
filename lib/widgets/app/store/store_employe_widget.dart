import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/global_method.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';

class StoreEmployeWidget extends StatelessWidget {
  final List<UserModel> employees;
  final Color? backgroundColor;
  final Color? textColor;

  const StoreEmployeWidget({
    super.key,
    required this.employees,
    this.backgroundColor = AppColors.backgroundColor,
    this.textColor = AppColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.employe_all_bar_title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: backgroundColor,
          ),
        ),

        const SizedBox(height: 12),

        ...employees.map(
          (e) => Card(
            color: backgroundColor,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  e.personModel?.profileImageUrl ??
                      'assets/images/profile/default_avatar.jpg',
                ),
              ),
              title: DisplayWidget(
                text: e.personModel?.name ?? '',
                textAlign: TextAlign.left,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                textColor: AppColors.textColor,
              ),
              subtitle: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child:  DisplayWidget(text: UserRole.Manager.name, textAlign: TextAlign.left, textColor: AppColors.textColor,)),
                  const SizedBox(width: 8), // spacing between role and status
                  SizedBox(
                    width: 10,
                    child: Icon(
                      Icons.circle,
                      size: 12, // smaller size for status
                      color: e.isActive ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              onTap: () {
                GlobalMethods.showEmployeeBottomSheet(context, e);
              },
            ),
          ),
        ),
      ],
    );
  }
}
