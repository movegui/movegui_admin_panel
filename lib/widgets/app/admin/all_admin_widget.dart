import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget_title.dart';

class AllAdminWidget extends StatefulWidget {
  const AllAdminWidget({super.key});

  @override
  State<StatefulWidget> createState() => AllAdminWidgetState();
}

class AllAdminWidgetState extends State<AllAdminWidget> {
  List<UserModel> users = [];
  late UserService userService;

  @override
  void initState() {
    userService = getIt<UserService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allUsers = await userService.getAllModelsByRole(UserRole.Admin);
    setState(() {
      users = allUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive.isDesktop(context)
          ? buildDesktop(context)
          : buildMobile(context),
    );
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
                            DisplayWidget(
                              text: users[index].personModel!.name,
                              textAlign: TextAlign.left,
                            ),
                            DisplayWidget(
                              text: users[index].personModel!.email,
                            ),

                            DisplayWidget(
                              text: users[index].personModel!.phone,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle category tap
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
                    leading: Icon(Icons.person),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DisplayWidget(
                              text: users[index].personModel!.firstName,
                            ),
                            DisplayWidget(
                              text: users[index].personModel!.lastName,
                            ),
                            DisplayWidget(
                              text: users[index].personModel!.email,
                            ),

                            DisplayWidget(
                              text: users[index].personModel!.phone,
                            ),

                            DisplayWidget(text: users[index].role),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle category tap
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
