import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/responsive.dart';

class PressingServiceTypePicker extends StatefulWidget {
  final PressingServiceTypeModel? service;
  final ValueChanged<PressingServiceTypeModel?> onServiceTypeChange;
  final List<PressingServiceTypeModel>? servicesTypes;

  const PressingServiceTypePicker({
    super.key,
    required this.service,
    required this.onServiceTypeChange,
    this.servicesTypes
  });

  @override
  State<PressingServiceTypePicker> createState() => PressingServiceTypePickerState();
}

class PressingServiceTypePickerState extends State<PressingServiceTypePicker> {
  PressingServiceTypeModel? _selectedService;
  late List<PressingServiceTypeModel> allServiceTypes = [];

  @override
  void initState() {
    super.initState();
    _selectedService = widget.service;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadServiceTypes();
    });
  }

  Future<void> _loadServiceTypes() async {
    final loadedTypes = widget.servicesTypes != null && widget.servicesTypes!.isNotEmpty
        ? widget.servicesTypes!
        : await AppConstants.getPressingServicesTypes(context);

    if (!mounted) return;

    allServiceTypes = loadedTypes;
    if (_selectedService == null && allServiceTypes.isNotEmpty) {
      _selectedService = allServiceTypes.first;
    } else if (_selectedService != null &&
        !allServiceTypes.any((service) => service.id == _selectedService!.id)) {
      _selectedService = allServiceTypes.isNotEmpty ? allServiceTypes.first : null;
    }

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    final matchingServices = allServiceTypes
        .where((service) => service.id == _selectedService?.id)
        .toList();
    final selectedService = matchingServices.length == 1
        ? matchingServices.single
        : allServiceTypes.isNotEmpty
            ? allServiceTypes.first
            : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<PressingServiceTypeModel>(
          isExpanded: true,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(
              context,
            )!.pressing_services_types_title,
            prefixIcon: const Icon(Icons.category_outlined),
          ),

          value: selectedService,
          items: allServiceTypes.map((elem) {
            return DropdownMenuItem(
              value: elem,
              child: Responsive.isDesktop(context)
                  ? Text(
                      elem.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Text(
                      elem.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _selectedService = value);
            widget.onServiceTypeChange.call(value);
          },
        ),
      ],
    );
  }
}
