import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/providers/store_model_provider.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/loading_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget_title.dart';

class AllPressingWidget extends ConsumerStatefulWidget {
  const AllPressingWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AllPressingWidgetPageState();
}

class AllPressingWidgetPageState extends ConsumerState<AllPressingWidget> {
  List<PressingModel> pressings = [];
  late PressingService pressingService;
  bool isloading = false;

  @override
  void initState() {
    pressingService = getIt<PressingService>(); //CategoriesService();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    setState(() {
      isloading = true;
    });
    final allPressings = await pressingService.allModels();

    setState(() {
      pressings = allPressings;
      isloading = false;
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
        if (isloading) LoadingWidget(),
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
                  text: AppLocalizations.of(context)!.label_adress,
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
            itemCount: pressings.length,
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
                                text: pressings[index].name,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: DisplayWidget(
                                text:
                                    '${pressings[index].address.district} ${pressings[index].address.minucipality} ',
                              ),
                            ),

                            Expanded(
                              child: DisplayWidget(
                                text: pressings[index].staff[0].personModel!.phone,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      ref
                          .read(StoreModelProvider.storeModelProvider)
                          .setStoreId(pressings[index].id);
                      context.go(
                        '${RouteConstants.STORE_DETAIL_ROUTE}/${pressings[index].id}',
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
        if (isloading) LoadingWidget(),
        SizedBox(height: 6),
        Container(
          color: AppColors.backgroundColor,
          child: ListTile(
            leading: Icon(Icons.cleaning_services, color: AppColors.textColor),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_name,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_adress,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_phone,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_district,
                ),
                DisplayWidgetTitle(
                  text: AppLocalizations.of(context)!.label_municipality,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: pressings.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.cleaning_services, color: AppColors.backgroundColor,),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: DisplayWidget(text: pressings[index].name)),
                            Expanded(
                              child: DisplayWidget(
                                text: pressings[index].address.address,
                              ),
                            ),
                            Expanded(child: DisplayWidget(text: pressings[index].phone)),

                            Expanded(
                              child: DisplayWidget(
                                text: pressings[index].address.district,
                              ),
                            ),

                            Expanded(
                              child: DisplayWidget(
                                text: AppConstants.getMunicipality(
                                  pressings[index].address.minucipality!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      ref
                          .read(StoreModelProvider.storeModelProvider)
                          .setStoreId(pressings[index].id);
                      context.go(
                        '${RouteConstants.STORE_DETAIL_ROUTE}/${pressings[index].id}',
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
