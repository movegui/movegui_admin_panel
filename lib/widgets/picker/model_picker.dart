import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/types_model.dart';
import 'package:movegui_admin_panel/responsive.dart';

class ModelPicker<M extends TypesModel> extends StatefulWidget {
  final M? selectedModel;
  final ValueChanged<M?> onSelectedModelChange;
  final List<M>? models;

  const ModelPicker({
    super.key,
    required this.selectedModel,
    required this.onSelectedModelChange,
    required this.models
  });

  @override
  State<ModelPicker<M>> createState() => ModelPickerState<M>();
}

class ModelPickerState<M extends TypesModel> extends State<ModelPicker<M>> {
  M? _selectedService;
  late List<M> allServiceTypes = [];

  @override
  void initState() {
    super.initState();
    _selectedService = widget.selectedModel;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadServiceTypes();
    });
  }

  Future<void> _loadServiceTypes() async {
    final loadedTypes = widget.models != null && widget.models!.isNotEmpty
        ? widget.models!
        : await AppConstants.getPressingServicesTypes(context);

    if (!mounted) return;

    allServiceTypes = loadedTypes as List<M>;
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
        DropdownButtonFormField<M>(
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
            widget.onSelectedModelChange.call(value);
          },
        ),
      ],
    );
  }
}
