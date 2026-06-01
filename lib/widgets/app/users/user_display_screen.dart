import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/global_method.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget_title.dart';

class UserDisplayScreen extends StatelessWidget {
  final List<UserModel> users;

  const UserDisplayScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? buildDesktop(context)
        : buildMobile(context);
  }

  Widget buildMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Container(
          color: AppColors.backgroundColor,
          child: ListTile(
            //  leading: Icon(Icons.person),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_name,
                  textAlign: TextAlign.left,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_email,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_phone,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    // leading: Icon(Icons.person),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DisplayWidget(
                                text: users[index].personModel!.name,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: DisplayWidget(
                                text: users[index].personModel!.email,
                              ),
                            ),

                            Expanded(
                              child: DisplayWidget(
                                text: users[index].personModel!.phone,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      GlobalMethods.showEmployeeBottomSheet(
                        context,
                        users[index],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDesktop(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Container(
          color: AppColors.backgroundColor,
          child: ListTile(
            leading: Icon(Icons.person, color: AppColors.textColor),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_firstname,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_lastname,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_email,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_phone,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_role,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: AppColors.backgroundColor,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DisplayWidget(
                                text: users[index].personModel!.firstName,
                              ),
                            ),
                            Expanded(
                              child: DisplayWidget(
                                text: users[index].personModel!.lastName,
                              ),
                            ),
                            Expanded(
                              child: DisplayWidget(
                                text: users[index].personModel!.email,
                              ),
                            ),

                            Expanded(
                              child: DisplayWidget(
                                text: users[index].personModel!.phone,
                              ),
                            ),

                            Expanded(
                              child: DisplayWidget(text: users[index].role),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      GlobalMethods.showEmployeeBottomSheet(
                        context,
                        users[index],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
