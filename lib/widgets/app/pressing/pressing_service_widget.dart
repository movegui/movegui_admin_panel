import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/pressing_service_type_picker.dart';
import 'package:movegui_admin_panel/widgets/picker/price_type_picker.dart';
import 'package:movegui_admin_panel/widgets/util/section_title_widget.dart';
import 'package:movegui_admin_panel/widgets/util/status_toggle_widget.dart';

class PressingServiceWidget extends StatelessWidget {
  final PressingServiceFormController controller;
  final ValueChanged<PressingServiceTypeModel?> onServiceTypeChange;
  final ValueChanged<PricingType?> onPricingTypeChange;
  final ValueChanged<bool> onStatusChange;
  final PressingServiceTypeModel? selectedServiceType;

  const PressingServiceWidget({
    super.key,
    required this.controller,
    required this.onServiceTypeChange,
    required this.onPricingTypeChange,
    required this.onStatusChange,
    required this.selectedServiceType,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    /*
    final l10n = AppLocalizations.of(context)!;
    final serviceType =
        controller.serviceType ??
        PressingServiceTypeModel(
          id: PricingType.fixed.id,
          name: l10n.pressing_service_dry_cleaning,
          description: l10n.pressing_service_dry_cleaning_descrip,
          pricingType: PricingType.fixed,
          createdAt: DateTime.now(),
        );
        */

    return isDesktop
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionTitleWidget(
                icon: Icons.info_outline,
                title: AppLocalizations.of(
                  context,
                )!.pressing_service_info_title,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: PressingServiceTypePicker(
                      service:
                          selectedServiceType ??
                          PressingServiceTypeModel(
                            id: '003',
                            name: AppLocalizations.of(
                              context,
                            )!.pressing_service_dry_cleaning,
                            description: AppLocalizations.of(
                              context,
                            )!.pressing_service_dry_cleaning_descrip,
                            pricingType: PricingType.fixed,
                            createdAt: DateTime.now(),
                          ),
                      onServiceTypeChange: onServiceTypeChange,
                      servicesTypes: selectedServiceType != null
                          ? [selectedServiceType!]
                          : [],
                    ),
                  ),
                  const SizedBox(width: WidgetConstants.sepWidget),
                  Expanded(
                    //    flex: 2,
                    child: InputWidget(
                      controller: controller.name,
                      focusNode: controller.nameFocusNode,
                      prefixIcon: const Icon(Icons.local_laundry_service),
                      labelText: AppLocalizations.of(
                        context,
                      )!.pressing_service_hinterText,
                      hintText: AppLocalizations.of(
                        context,
                      )!.pressing_service_hinterText,
                      validator: (value) {
                        return MyValidators.textNameValidator(value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: WidgetConstants.sepWidget * 2),
              InputWidget(
                controller: controller.description,
                labelText: AppLocalizations.of(context)!.description_title,
                hintText: AppLocalizations.of(context)!.description_hint_text,
                textInputType: TextInputType.multiline,
                maxLines: 5,
                nextFocusNode: controller.minPriceFocusNode,
                validator: MyValidators.textValidator,
                prefixIcon: const Icon(Icons.message),
                focusNode: controller.descriptionFocusNode,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              SectionTitleWidget(
                icon: Icons.payments_outlined,
                title: AppLocalizations.of(
                  context,
                )!.pressing_service_tarification_title,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputWidget(
                      controller: controller.minPrice,
                      textInputType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      hintText: AppLocalizations.of(
                        context,
                      )!.pressing_service_price_min_hinterText,
                      labelText: AppLocalizations.of(
                        context,
                      )!.pressing_service_price_min_labelText,
                      validator: MyValidators.priceValidator,
                      focusNode: controller.minPriceFocusNode,
                      nextFocusNode: controller.maxPriceFocusNode,
                      prefixIcon: Icon(Icons.attach_money_rounded),
                    ),
                  ),
                  const SizedBox(width: WidgetConstants.sepWidget),
                  Expanded(
                    child: InputWidget(
                      controller: controller.maxPrice,
                      textInputType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: MyValidators.priceValidator,
                      focusNode: controller.maxPriceFocusNode,
                      hintText: AppLocalizations.of(
                        context,
                      )!.pressing_service_price_max_hinterText,
                      labelText: AppLocalizations.of(
                        context,
                      )!.pressing_service_price_max_labelText,
                      prefixIcon: Icon(Icons.attach_money_rounded),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: WidgetConstants.sepWidget * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    //        flex: 2,
                    child: PriceTypePicker(
                      pricingType:
                          controller.serviceType?.pricingType ??
                          PricingType.fixed,
                      onPricingTypeChange: onPricingTypeChange,
                    ),
                  ),
                  const SizedBox(width: WidgetConstants.sepWidget),
                  Expanded(
                    child: InputWidget(
                      controller: controller.processingTime,
                      textInputType: TextInputType.number,
                      labelText: AppLocalizations.of(
                        context,
                      )!.pressing_service_estimated_duration_labelText,
                      hintText: AppLocalizations.of(
                        context,
                      )!.pressing_service_estimated_duration_hinterText,
                      prefixIcon: Icon(Icons.schedule_outlined),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.tooltip_duree_invalide;
                        }

                        final duration = int.tryParse(value);

                        if (duration == null || duration <= 0) {
                          return AppLocalizations.of(
                            context,
                          )!.error_duree_invalide;
                        }

                        return null;
                      },
                      focusNode: controller.processingTimeFocusNode,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: WidgetConstants.sepWidget),
              StatusToggleWidget(
                isActive: controller.isActive,
                onChanged: onStatusChange,
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 2,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionTitleWidget(
                icon: Icons.info_outline,
                title: AppLocalizations.of(
                  context,
                )!.pressing_service_info_title,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              PressingServiceTypePicker(
                service: selectedServiceType,
                onServiceTypeChange: onServiceTypeChange,
                servicesTypes: selectedServiceType != null
                    ? [selectedServiceType!]
                    : [],
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              InputWidget(
                controller: controller.name,
                focusNode: controller.nameFocusNode,
                prefixIcon: const Icon(Icons.local_laundry_service),
                labelText: AppLocalizations.of(
                  context,
                )!.pressing_service_hinterText,
                hintText: AppLocalizations.of(
                  context,
                )!.pressing_service_hinterText,
                validator: (value) {
                  return MyValidators.textNameValidator(value);
                },
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              InputWidget(
                controller: controller.description,
                labelText: AppLocalizations.of(context)!.description_title,
                hintText: AppLocalizations.of(context)!.description_hint_text,
                textInputType: TextInputType.multiline,
                maxLines: 5,
                nextFocusNode: controller.minPriceFocusNode,
                validator: MyValidators.textValidator,
                prefixIcon: const Icon(Icons.message),
                focusNode: controller.descriptionFocusNode,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              SectionTitleWidget(
                icon: Icons.payments_outlined,
                title: AppLocalizations.of(
                  context,
                )!.pressing_service_tarification_title,
              ),
              InputWidget(
                controller: controller.minPrice,
                textInputType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                hintText: AppLocalizations.of(
                  context,
                )!.pressing_service_price_min_hinterText,
                labelText: AppLocalizations.of(
                  context,
                )!.pressing_service_price_min_hinterText,
                validator: MyValidators.priceValidator,
                focusNode: controller.minPriceFocusNode,
                nextFocusNode: controller.maxPriceFocusNode,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              InputWidget(
                controller: controller.maxPrice,
                textInputType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: MyValidators.priceValidator,
                focusNode: controller.maxPriceFocusNode,
                hintText: AppLocalizations.of(
                  context,
                )!.pressing_service_price_max_hinterText,
                labelText: AppLocalizations.of(
                  context,
                )!.pressing_service_price_max_hinterText,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              PriceTypePicker(
                pricingType:
                    controller.serviceType?.pricingType ?? PricingType.fixed,
                onPricingTypeChange: onPricingTypeChange,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              InputWidget(
                controller: controller.processingTime,
                textInputType: TextInputType.number,
                labelText: AppLocalizations.of(
                  context,
                )!.pressing_service_estimated_duration_labelText,
                hintText: AppLocalizations.of(
                  context,
                )!.pressing_service_estimated_duration_hinterText,
                prefixIcon: Icon(Icons.schedule_outlined),
                validator: MyValidators.durationValidator,
                focusNode: controller.processingTimeFocusNode,
              ),
              const SizedBox(height: WidgetConstants.sepWidget),
              StatusToggleWidget(
                isActive: controller.isActive,
                onChanged: onStatusChange,
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 2,
              ),
            ],
          );
  }
}
