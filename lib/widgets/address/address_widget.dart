import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/address_type_picker.dart';
import 'package:movegui_admin_panel/widgets/picker/commune_widget_picker.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class AddressWidget extends StatefulWidget {
  final AddressFormController addressForm;
  final ValueChanged<String?> onAdressTypeChange;
  final ValueChanged<String?> onCommuneChange;
  final ValueChanged<String?> onDefaultAdressChange;
  final VoidCallback? onUpdateAdresse;
  final VoidCallback? onRemoveAdress;
  final void Function(String) onChange;
  final bool? isFullBorder;
  final String defaultId;
  final bool? toEdit;

  const AddressWidget({
    super.key,
    required this.onCommuneChange,
    required this.onAdressTypeChange,
    this.isFullBorder = true,
    required this.addressForm,
    required this.onChange,
    required this.defaultId,
    required this.onDefaultAdressChange,
    this.onUpdateAdresse,
    this.onRemoveAdress,
    this.toEdit = false,
  });

  @override
  State<StatefulWidget> createState() => AddressWidgetState();
}

class AddressWidgetState extends State<AddressWidget> {
  late bool _readOnly = widget.addressForm.isValid()
      ? widget.toEdit!
            ? false
            : true
      : false;

  @override
  Widget build(BuildContext context) {
    return Column(
      //  key: addAddressKey,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.isDesktop(context)
                  ? 150
                  : MediaQuery.of(context).size.width * 0.3,
              child: AddressTypePicker(
                adresseType: widget.addressForm.selectedType,
                onAdressTypeChange: (type) {
                  setState(() {
                    widget.addressForm.selectedType = type!;
                    widget.onAdressTypeChange.call(type);
                  });
                },
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: widget.addressForm.address,
                focusNode: widget.addressForm.addressFocusNode,
                prefixIcon: Icon(Icons.home),
                hintText: AppLocalizations.of(context)!.input_hint_adress,
                isFullBorder: widget.isFullBorder,
                validator: (vaule) {
                  return MyValidators.textNameValidator(vaule);
                },
                onChange: (value) {
                  widget.onChange.call(value);
                },
                readOnly: _readOnly,
                maxLines: 2,
                textInputType: TextInputType.multiline,
            //    isNumber: false,
                inputFormatters: [],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.isDesktop(context)
                  ? 150
                  : MediaQuery.of(context).size.width * 0.3,
              child: CommuneWidgetPicker(
                commune: widget.addressForm.selectedMunicipality,
                onCommuneChange: (value) {
                  widget.addressForm.selectedMunicipality = value!;
                  widget.onCommuneChange.call(value);
                },
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: widget.addressForm.district,
                focusNode: widget.addressForm.districtFocus,
                prefixIcon: Icon(Icons.home),
                hintText: AppLocalizations.of(context)!.input_hint_quartier,
                isFullBorder: widget.isFullBorder,
                validator: (vaule) {
                  return MyValidators.textNameValidator(vaule);
                },
                onChange: (value) {
                  widget.onChange(value);
                },
                readOnly: _readOnly,
                maxLines: 2,
                textInputType: TextInputType.multiline,
              //  isNumber: false,
              ),
            ),
          ],
        ),
        standardAdresseWidget(),
        widget.addressForm.isValid() && !widget.toEdit!
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: updateButtonWidget()),
                  SizedBox(width: WidgetConstants.sepWidgetHeight),
                  Expanded(child: removeButtonWidget()),
                ],
              )
            : SizedBox(),
        SeparatorWidget(height: 6),
      ],
    );
  }

  Widget updateButtonWidget() {
    return ButtonWidget(
      onPressed: (item) async {
        setState(() {
          _readOnly = false;
        });
        widget.onUpdateAdresse?.call();
      },
      buttonItem: ButtonInfo(
        title: AppLocalizations.of(context)!.btn_update_adress,
        enabled: widget.addressForm.isValid(),
        routeName: '',
      ),
      icon: Icon(Icons.edit),
    );
  }

  Widget standardAdresseWidget() {
    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.standard_address,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Radio<String>(
            value: widget.addressForm.id!,
            groupValue: widget.defaultId,
            onChanged: (value) {
              widget.onDefaultAdressChange.call(value);
            },
          ),
        ),
      ],
    );
  }

  Widget removeButtonWidget() {
    return ButtonWidget(
      onPressed: (item) async {
        widget.onRemoveAdress?.call();
      },
      buttonItem: ButtonInfo(
        title: AppLocalizations.of(context)!.btn_delete_adress,
        enabled: widget.addressForm.isValid(),
        routeName: '',
      ),
      icon: Icon(Icons.delete),
      //  textColor: Colors.red,
    );
  }
}
