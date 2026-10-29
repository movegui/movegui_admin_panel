import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/util/pressing_service_type_form_controller.dart';
import 'package:movegui_admin_panel/widgets/input/input_name_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/price_type_picker.dart';
import 'package:movegui_admin_panel/widgets/util/layout_buider_widget.dart';
import 'package:movegui_admin_panel/widgets/util/status_toggle_widget.dart';

class PressingServiceTypeWidget extends StatelessWidget {
   const PressingServiceTypeWidget({
    super.key,
    required this.controller,
    required this.onStatusChange,
    required this.onPricingTypeChange,
  });
  final PressingServiceTypeFormController controller;
  final ValueChanged<bool> onStatusChange;
  final ValueChanged<PricingType?> onPricingTypeChange;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGeneralFields(context),

          const SizedBox(height: WidgetConstants.sepWidget),

          StatusToggleWidget(
            isActive: controller.isActive ?? false,
            onChanged: onStatusChange,
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralFields(BuildContext context) {
    return Column(
      children: [
        LayoutBuilderWidget(
          use2_1: true,
          children: [
            InputNameWidget(
              nameController: controller.name,
              labelText: 'Name Type Service',
              hinterText: 'Ex Netteyage Sec',
              nextFocusNode: controller.descriptionFocus,
              icon: Icons.category,
              nameFocusNode: controller.nameFocusNode,
            ),
            PriceTypePicker(
              pricingType: controller.pricingType ?? PricingType.perItem,
              onPricingTypeChange: onPricingTypeChange,
            ),
          ],
        ),

        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputWidget(
          controller: controller.description,
          labelText: 'Description',
          hintText: 'Veuillez decrire les carateristique du type service',
          textInputType: TextInputType.multiline,
          maxLines: 6,
          validator: MyValidators.textValidator,
          prefixIcon: Icon(Icons.message),
          focusNode: controller.descriptionFocus,
          onChange: (String value) {},
          isFullBorder: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ],
    );
  }
}
