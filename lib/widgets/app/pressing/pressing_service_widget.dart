import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/pressing_service_picker.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class PressingServiceWidget extends StatefulWidget {
  const PressingServiceWidget({super.key, required this.formControllers});
  final List<PressingServiceFormController> formControllers;

  @override
  State<StatefulWidget> createState() => PressingServiceWidgetState();
}

class PressingServiceWidgetState extends State<PressingServiceWidget> {
  late PressingServiceTypeModel? _pressinServiceType;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pressinServiceType = PressingServiceTypeModel(
      id: '003',
      name: AppLocalizations.of(context)!.pressing_service_dry_cleaning,
      description: AppLocalizations.of(
        context,
      )!.pressing_service_dry_cleaning_descrip,
      pricingType: PricingType.fixed.name,
      createdAt: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.formControllers.length,
        itemBuilder: (context, index) {
          widget.formControllers[index].serviceType = _pressinServiceType;
          return Center(
            child: Container(
              width: Responsive.isDesktop(context)
                  ? size.width * 0.5
                  : double.infinity,
              //   height: Size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    AppColors.backgroundColor, //Colors.grey.withOpacity(0.3),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: PressingServicePicker(
                            service: widget
                                .formControllers[index]
                                .serviceType, //_pressinServiceType,
                            onServiceChange: (PressingServiceTypeModel? value) {
                              setState(() {
                                // _pressinServiceType = value;
                                widget.formControllers[index].serviceType =
                                    value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: Responsive.isDesktop(context) ? 2 : 1,
                        child: InputWidget(
                          controller: widget.formControllers[index].name,
                          focusNode:
                              widget.formControllers[index].nameFocusNode,
                          icon: Icons.local_laundry_service,
                          labelText: AppLocalizations.of(
                            context,
                          )!.pressing_service_labelText,
                          hinterText: AppLocalizations.of(
                            context,
                          )!.pressing_service_hinterText,
                          validator: (vaule) {
                            return MyValidators.textNameValidator(vaule);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InputWidget(
                          controller: widget.formControllers[index].minPrice,
                          focusNode:
                              widget.formControllers[index].minPriceFocusNode,
                          icon: Icons.price_check,
                          labelText: AppLocalizations.of(
                            context,
                          )!.pressing_service_price_min_labelText,
                          hinterText: AppLocalizations.of(
                            context,
                          )!.pressing_service_price_min_hinterText,
                          textInputType: TextInputType.number,
                          validator: (vaule) {
                            return MyValidators.numberValidator(vaule);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InputWidget(
                          controller: widget.formControllers[index].maxPrice,
                          focusNode:
                              widget.formControllers[index].maxPriceFocusNode,
                          icon: Icons.price_check,
                          labelText: AppLocalizations.of(
                            context,
                          )!.pressing_service_price_max_labelText,
                          hinterText: AppLocalizations.of(
                            context,
                          )!.pressing_service_price_max_hinterText,
                          textInputType: TextInputType.number,
                          validator: (vaule) {
                            return MyValidators.numberValidator(vaule);
                          },
                        ),
                      ),
                    ],
                  ),

                  SeparatorWidget(height: WidgetConstants.sepWidget * 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          onPressed: (item) async {
                            setState(() {
                              widget.formControllers.add(
                                PressingServiceFormController(),
                              );
                            });
                          },
                          buttonItem: ButtonItem(
                            AppLocalizations.of(
                              context,
                            )!.btn_add_pressing_service,
                            onPress: () {},
                            tooltipText: AppLocalizations.of(
                              context,
                            )!.tooltip_btn_add_pressing_service,
                            enabled: true,
                            routeName: '',
                          ),
                          icon: Icons.add,
                          backgroundColor: AppColors.darkPrimary,
                        ),
                      ),

                      Expanded(
                        child: IconButton(
                          onPressed: () => {
                            setState(() {
                              widget.formControllers.removeAt(index);
                            }),
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: WidgetConstants.sepWidget);
        },
      ),
    );
  }
}
