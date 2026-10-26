import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/widgets/address/single_adress_widget.dart';
import 'package:movegui_admin_panel/widgets/image_picker_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_email_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_name_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_phone_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';
import 'package:movegui_admin_panel/widgets/section_header_widget.dart';
import 'package:movegui_admin_panel/widgets/util/form_card_widget.dart';
import 'package:movegui_admin_panel/widgets/util/layout_buider_widget.dart';
import 'package:movegui_admin_panel/widgets/util/status_switch_widget.dart';

class StoreWidget extends StatelessWidget {
  final StoreFormController formController;
  final void Function(String?) onAdressTypeChange;
  final void Function(String?) onCommuneChange;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final StoreConstants storeConstants;
  final Function(List<OpenHoursModel>) onHoursChanged;
  final ValueChanged<bool> onStatusChanged;

  const StoreWidget({
    super.key,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.storeConstants,
    required this.onAdressTypeChange,
    required this.onCommuneChange,
    required this.formController,
    required this.onHoursChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Center(
      child: Column(
        children: [
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            children: [
              if (isDesktop)
                Expanded(child: _buildContent(context, isDesktop))
              else
                _buildContent(context, isDesktop),
              SizedBox(height: WidgetConstants.sepWidget),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isDesktop) {
    return FormCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context, isDesktop),
          const SizedBox(height: WidgetConstants.sepWidget),
          _buildInformationSection(context, isDesktop),
          const SizedBox(height: WidgetConstants.sepWidget),
          _buildContactSection(context, isDesktop),
          const SizedBox(height: WidgetConstants.sepWidget),
          _buildAdressSection(context),
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context, bool isDesktop) {
    final imagePicker = ImagePickerWidget(
      webImage: formController.webImage,
      pickedImage: formController.pickedImage,
      imageUrl: formController.imageUrl,
      onPickImage: onPickImage,
      onRemoveImage: onRemoveImage,
    );

    final validatedImagePicker = FormField<bool>(
      validator: (_) {
        return formController.hasImage ? null : 'Veuillez choisir une image.';
      },
      builder: (field) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          imagePicker,
          if (field.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                field.errorText!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );

    return Padding(
      padding: isDesktop
          ? const EdgeInsets.only(right: WidgetConstants.sepWidgetHeight * 2)
          : const EdgeInsets.all(8.0),
      child: validatedImagePicker,
    );
  }

  Widget _buildHeaderSection(BuildContext context, bool isDesktop) {
    return LayoutBuilderWidget(
      children: [
        SectionHeaderWidget(
          icon: Icons.info,
          title: AppLocalizations.of(context)!.store_information_title,
          subtitle: AppLocalizations.of(context)!.store_information_subtitle,
          iconColor: Colors.blueAccent,
        ),
        StatusSwitchWidget(
          value: formController.isActive ?? false,
          onChanged: onStatusChanged,
        ),
      ],
    );

    /*
    return Flex(
      direction: isDesktop ? Axis.horizontal : Axis.vertical,
      children: [
        if (isDesktop)
          Expanded(
            child: SectionHeaderWidget(
              icon: Icons.info,
              title: AppLocalizations.of(context)!.store_information_title,
              subtitle: AppLocalizations.of(
                context,
              )!.store_information_subtitle,
              iconColor: Colors.blueAccent,
            ),
          )
        else
          SectionHeaderWidget(
            icon: Icons.storefront_outlined,
            title: AppLocalizations.of(context)!.store_information_title,
            subtitle: AppLocalizations.of(context)!.store_information_subtitle,
          ),
        StatusSwitchWidget(value: formController.isActive ?? false, onChanged: onStatusChanged),
      ],
    );
    */
  }

  Widget _buildInformationSection(BuildContext context, bool isDesktop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildGeneralFields(context)),
              const SizedBox(width: WidgetConstants.sepWidget),
              SizedBox(
                width: 280,
                child: _buildImagePicker(context, isDesktop),
              ),
            ],
          );
        }

        return Column(
          children: [
            _buildImagePicker(context, isDesktop),
            const SizedBox(height: WidgetConstants.sepWidget),
            _buildGeneralFields(context),
          ],
        );
      },
    );
  }

  Widget _buildContactSection(BuildContext context, bool isDesktop) {
    return Column(
      children: [
        SectionHeaderWidget(
          icon: Icons.contact_mail_outlined,
          title: AppLocalizations.of(context)!.store_contact_title,
          subtitle: AppLocalizations.of(context)!.store_contact_subtitle,
          iconColor: Colors.greenAccent,
        ),

        const SizedBox(height: WidgetConstants.sepWidget),

        LayoutBuilder(
          builder: (context, constraints) {
            final emailField = InputEmailWidget(
              emailController: formController.email,
              labelText: storeConstants.getEmailLabelText(context),
              nextFocusNode: formController.telephonFocus,
              emailFocusNode: formController.emailFocus,
            );

            final phoneField = InputPhoneWidget(
              phoneController: formController.phone,
              labelText: storeConstants.getPhoneLabelText(context),
              phoneFocusNode: formController.telephonFocus,
            );

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: emailField),
                  const SizedBox(width: 16),
                  Expanded(child: phoneField),
                ],
              );
            }

            return Column(
              children: [emailField, const SizedBox(height: 16), phoneField],
            );
          },
        ),
      ],
    );
  }

  Widget _buildAdressSection(BuildContext context) {
    return Column(
      children: [
        SectionHeaderWidget(
          icon: Icons.location_on_outlined,
          title: AppLocalizations.of(context)!.store_adress_title,
          subtitle: AppLocalizations.of(context)!.store_adress_subtitle,
          iconColor: Colors.red,
        ),
        SizedBox(height: WidgetConstants.sepWidget),
        SingleAdressWidget(
          onCommuneChange: onCommuneChange,
          onAdressTypeChange: onAdressTypeChange,
          isFullBorder: true,
          addressForm: formController.addressForm,
        ),
      ],
    );
  }

  Widget _buildGeneralFields(BuildContext context) {
    return Column(
      children: [
        InputNameWidget(
          nameController: formController.name,
          labelText: storeConstants.getNameLabelText(context),
          hinterText: storeConstants.getNameHinterText(context),
          nextFocusNode: formController.descriptionFocus,
          icon: Icons.business,
          nameFocusNode: formController.nameFocus,
        ),
        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputWidget(
          controller: formController.description,
          labelText: storeConstants.getDescripLabelText(context),
          hintText: storeConstants.getDescripHinterText(context),
          textInputType: TextInputType.multiline,
          maxLines: 6,
          nextFocusNode: formController.addressForm.addressFocusNode,
          validator: MyValidators.textValidator,
          prefixIcon: Icon(Icons.message),
          focusNode: formController.descriptionFocus,
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
