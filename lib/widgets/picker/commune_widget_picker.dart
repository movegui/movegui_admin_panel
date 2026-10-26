import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';

class CommuneWidgetPicker extends StatefulWidget {
  final String? commune;
  final ValueChanged<String?> onCommuneChange;

  const CommuneWidgetPicker({
    super.key,
    required this.commune,
    required this.onCommuneChange,
  });

  @override
  State<CommuneWidgetPicker> createState() => CommuneWidgetPickerState();
}

class CommuneWidgetPickerState extends State<CommuneWidgetPicker> {
  String? _selectedCommune;

  @override
  void initState() {
    super.initState();
    _selectedCommune = _toCommuneCode(widget.commune);
  }

  @override
  void didUpdateWidget(covariant CommuneWidgetPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.commune != widget.commune) {
      _selectedCommune = _toCommuneCode(widget.commune);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Responsive.isDesktop(context)
        ? Theme.of(context).textTheme.bodyMedium
        : Theme.of(context).textTheme.bodySmall;
    final labelStyle = Responsive.isDesktop(context)
        ? Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)
        : Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 14);
    return Card(
      //   color: AppColors.backgroundColor,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                //   fillColor: AppColors.backgroundColor,
                labelText: AppLocalizations.of(context)!.commune_title,
                labelStyle: labelStyle,
                border: InputBorder.none,
              ),
              value: _toCommuneCode(_selectedCommune),
              items: [
                DropdownMenuItem(
                  value: 'di',
                  child: Text(COMMUNE_DIXINN, style: style),
                ),
                DropdownMenuItem(
                  value: 'gb',
                  child: Text(COMMUNE_GBESSIA, style: style),
                ),
                DropdownMenuItem(
                  value: 'ka',
                  child: Text(COMMUNE_KALOUM, style: style),
                ),
                DropdownMenuItem(
                  value: 'kg',
                  child: Text(COMMUNE_KAGBELEN, style: style),
                ),
                DropdownMenuItem(
                  value: 'ks',
                  child: Text(COMMUNE_KASSA, style: style),
                ),
                DropdownMenuItem(
                  value: 'la',
                  child: Text(COMMUNE_LAMBANYI, style: style),
                ),
                DropdownMenuItem(
                  value: 'ma',
                  child: Text(COMMUNE_MATAM, style: style),
                ),
                DropdownMenuItem(
                  value: 'mn',
                  child: Text(COMMUNE_MANEAH, style: style),
                ),
                DropdownMenuItem(
                  value: 'mt',
                  child: Text(COMMUNE_MATOTO, style: style),
                ),
                DropdownMenuItem(
                  value: 'ra',
                  child: Text(COMMUNE_RATOMA, style: style),
                ),
                DropdownMenuItem(
                  value: 'so',
                  child: Text(COMMUNE_SONFONIA, style: style),
                ),
                DropdownMenuItem(
                  value: 'sn',
                  child: Text(COMMUNE_SANOYAH, style: style),
                ),
                DropdownMenuItem(
                  value: 'to',
                  child: Text(COMMUNE_TOMBOLIA, style: style),
                ),
              ],

              onChanged: (value) {
                setState(() => _selectedCommune = value);
                widget.onCommuneChange.call(value);
              },
              validator: (value) {
                return MyValidators.textValidator(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  String? _toCommuneCode(String? value) {
    if (value == null) return null;

    const labels = {
      'di': COMMUNE_DIXINN,
      'gb': COMMUNE_GBESSIA,
      'ka': COMMUNE_KALOUM,
      'kg': COMMUNE_KAGBELEN,
      'ks': COMMUNE_KASSA,
      'la': COMMUNE_LAMBANYI,
      'ma': COMMUNE_MATAM,
      'mn': COMMUNE_MANEAH,
      'mt': COMMUNE_MATOTO,
      'ra': COMMUNE_RATOMA,
      'so': COMMUNE_SONFONIA,
      'sn': COMMUNE_SANOYAH,
      'to': COMMUNE_TOMBOLIA,
    };

    if (labels.containsKey(value)) return value;

    for (final entry in labels.entries) {
      if (entry.value == value) return entry.key;
    }

    return null;
  }

  String getCommuneLabel(String value) {
    switch (value) {
      case 'di':
        return COMMUNE_DIXINN;
      case 'gb':
        return COMMUNE_GBESSIA;
      case 'ka':
        return COMMUNE_KALOUM;
      case 'kg':
        return COMMUNE_KAGBELEN;
      case 'ks':
        return COMMUNE_KASSA;
      case 'la':
        return COMMUNE_LAMBANYI;
      case 'ma':
        return COMMUNE_MATAM;
      case 'mn':
        return COMMUNE_MANEAH;
      case 'mt':
        return COMMUNE_MATOTO;
      case 'ra':
        return COMMUNE_RATOMA;
      case 'so':
        return COMMUNE_SONFONIA;
      case 'sn':
        return COMMUNE_SANOYAH;
      case 'to':
        return COMMUNE_TOMBOLIA;
      default:
        return '';
    }
  }
}
