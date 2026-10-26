import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/providers/store_model_provider.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_tab_header_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_tab_row_widget.dart';

class AllPressingPage extends ConsumerStatefulWidget {
  const AllPressingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AllPressingPageState();
}

class AllPressingPageState extends ConsumerState<AllPressingPage> {
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
    return Column(
      children: [
        DashboardHeader(
          title: AppLocalizations.of(context)!.pressing_all_dashboard_title,
          subtitle: AppLocalizations.of(
            context,
          )!.pressing_all_dashboard_sub_title,
          onPressed: (item) async {
            context.go(RouteConstants.PRESSING_ADD_ROUTE);
          },
          buttonText: AppLocalizations.of(context)!.btn_add_pressing,
        ),
        const SizedBox(height: WidgetConstants.sepWidget),
        Card(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  //   key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PressingTabHeaderWidget(),
                      SizedBox(height: WidgetConstants.sepWidgetHeight),

                      ...pressings.map(
                        (press) => Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(StoreModelProvider.storeModelProvider)
                                  .setStoreId(press.id);

                              context.go(
                                '${RouteConstants.STORE_DETAIL_ROUTE}/${press.id}',
                              );
                            },
                            hoverColor: AppColors.selectionColor.withValues(
                              alpha: 0.08,
                            ),
                            child: PressingTabRowWidget(
                              pressing: press,
                              onEdit: (PressingModel value) {
                                context.go('${RouteConstants.PRESSING_EDIT_ROUTE}/${value.id}');
                              },
                              onDelete: (PressingModel value) async {
                                  await _deletePressing(context, value);
                              },
                              onChangeStatus: (PressingModel value) {
                                  setState(() {
                                  final pressing =  pressings.firstWhere((pressing) => pressing.id == value.id);
                                    pressing.isActive = !value.isActive!;
                                    pressingService.addModel(pressing);
                                  });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

    Future<void> _deletePressing(
    BuildContext dialogContext,
    PressingModel pressing
  ) async {
    final result = await MyAppFunctions.showConfirmationDialog(
      context: context,
      title: AppLocalizations.of(context)!.delete_pressing_title,
      question: AppLocalizations.of(context)!.delete_pressing_question,
    );
    if (result) {
      final index = pressings
          .indexWhere((press) => press.id == pressing.id)
          .toInt();
      if (index == -1) {
        return;
      }
    pressingService.deleteModel(pressing);
      setState(() {});
    }
  }
}
