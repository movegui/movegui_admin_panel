import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/services/form_services/adress_form_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/widgets/address/default_address_widget.dart';
import 'package:movegui_admin_panel/widgets/address/default_selection_widget.dart';


class DisplayAdressWidget extends StatefulWidget {
  const DisplayAdressWidget({
    super.key,
    required this.onEdit,
    required this.onRemove,
    required this.formController,
    required this.onDefaultChange,
    required this.defaultId,
  });

  final VoidCallback? onEdit;
  final VoidCallback? onRemove;
  final AddressFormController? formController;
  final ValueChanged<String?> onDefaultChange;
  final String? defaultId;

  @override
  State<StatefulWidget> createState() => DisplayAdressWidgetState();
}

class DisplayAdressWidgetState extends State<DisplayAdressWidget> {
  late AdressFormService addressFormService;

  @override
  void initState() {
    addressFormService = getIt<AdressFormService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Icon(
                    widget.formController?.selectedType == AddressType.HOME
                        ? Icons.home
                        : widget.formController?.selectedType ==
                            AddressType.OFFICE
                        ? Icons.work
                        : Icons.location_on,
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    addressFormService.getAdressType(
                      widget.formController?.selectedType ?? '',
                      context,
                    ),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.formController?.id == widget.defaultId)
                  DefaultAddressWidget(),
              ],
            ),
            const SizedBox(height: 4),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.formController?.address.text ?? '',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.formController?.district.text ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                DefaultSelectionWidget(
                  defaultId: widget.defaultId,
                  onDefaultChange: (String? value) {
                    widget.onDefaultChange.call(value);
                  },
                  selectedId: widget.formController?.id ?? '',
                ),
              ],
            ),
            const SizedBox(height: 4),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.onEdit,
                    icon: const Icon(Icons.edit),
                    label: Text(AppLocalizations.of(context)!.btn_update),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.onRemove,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: Text(
                      AppLocalizations.of(context)!.btn_delete,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /*
  Widget standardAdresseWidget() {
    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.standard_address,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Radio<String>(
            value: widget.formController?.id ?? '',
            groupValue: widget.defaultId,
            onChanged: (value) {
              widget.onDefaultChange.call(value);
            },
          ),
        ),
      ],
    );
  }
  */
}
