import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/responsive.dart';

class PriceTypePicker extends StatefulWidget {
  final PricingType? pricingType;
  final ValueChanged<PricingType?> onPricingTypeChange;

  const PriceTypePicker({
    super.key,
    required this.pricingType,
    required this.onPricingTypeChange,
  });

  @override
  State<PriceTypePicker> createState() => _PriceTypePickerState();
}

class _PriceTypePickerState extends State<PriceTypePicker> {
  PricingType? selectedPricingType;
  late List<PricingType> allPricingTypes = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPricingTypes();
    });
    selectedPricingType = widget.pricingType;
  }

  Future<void> _loadPricingTypes() async {
    allPricingTypes = [
      PricingType.fixed,
      PricingType.perItem,
      PricingType.perKg,
    ];
    setState(() {});
  }

  String _labelFor(PricingType type, AppLocalizations l10n) {
    return switch (type) {
      PricingType.perItem => l10n.pricingPerItem,
      PricingType.perKg => l10n.pricingPerKg,
      PricingType.fixed => l10n.pricingFixed,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<PricingType>(
          isExpanded: true,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(
              context,
            )!.pressing_services_pricing_type_title,
            prefixIcon: const Icon(Icons.category_outlined),
          ),

          value: selectedPricingType,
          items: allPricingTypes.map((elem) {
            return DropdownMenuItem(
              value: elem,
              child: Responsive.isDesktop(context)
                  ? Text(
                      _labelFor(elem, AppLocalizations.of(context)!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Text(
                      _labelFor(elem, AppLocalizations.of(context)!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => selectedPricingType = value);
            widget.onPricingTypeChange.call(value);
          },
        ),
      ],
    );
  }
}
