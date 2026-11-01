import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/global_method.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/section_title_widget.dart';

class StoreEmployeWidget extends StatelessWidget {
  final List<UserModel?>? employees;
  final List<Widget>? options;


  const StoreEmployeWidget({
    super.key,
    required this.employees,
    this.options
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

          SectionTitleWidget(
            title: AppLocalizations.of(context)!.employe_all_bar_title,
            subtitle: AppLocalizations.of(context)!.employe_all_bar_subtitle,
            childs: options ?? [],
          ),

        const SizedBox(height: WidgetConstants.sepWidget * 2),

        ...employees!.map(
          (e) => Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  e?.personModel?.profileImageUrl ??
                      'assets/images/profile/default_avatar.jpg',
                ),
              ),
              title: DisplayWidget(
                text: e?.personModel?.name ?? '',
                textAlign: TextAlign.left,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              subtitle: Row(
                children: [
                  DisplayWidget(text: e?.role.name ?? UserRole.Employe.name, textAlign: TextAlign.left,),
                  const SizedBox(width: WidgetConstants.sepWidget), 
                   Icon(
                      Icons.circle,
                      size: 12, // smaller size for status
                      color: e?.isActive != false ? Colors.green : Colors.red,
                    ),
                ],
              ),
              onTap: () {
                GlobalMethods.showEmployeeBottomSheet(context, e!);
              },
            ),
          ),
        ),
      ],
    );
  }
}
