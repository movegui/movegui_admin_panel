import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/widgets/util/item_widget.dart';
import 'package:movegui_admin_panel/widgets/util/section_title_widget.dart';
import 'package:movegui_admin_panel/widgets/util/status_chip_widget.dart';

class StoreInfoWidget extends StatelessWidget {
  final EstablishmentModel model;
  final List<Widget>? options;

  const StoreInfoWidget({super.key, required this.model, this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitleWidget(
            title: AppLocalizations.of(context)!.informations_title,
            subtitle: AppLocalizations.of(context)!.informations_subtitle,
            childs: options ?? [],
          ),
          SizedBox(height: WidgetConstants.sepWidget,),
          StatusChip(active: model.isActive == true, fontsize: 18,),
          const SizedBox(height: 18),
          ItemWidget(
            label: AppLocalizations.of(context)!.label_adress,
            value: model.address.address,
            icon: Icons.home,
            surface: 25,
            size: 17,
          ),
          ItemWidget(
            label: AppLocalizations.of(context)!.label_phone,
            value: model.phone,
            icon: Icons.phone,
            surface: 25,
          ),
          ItemWidget(
            label: AppLocalizations.of(context)!.label_email,
            value: model.email,
            icon: Icons.email,
          ),
          const SizedBox(height: 8),
          ItemWidget(
            label: AppLocalizations.of(context)!.description_title,
            value: model.description ?? '',
            icon: Icons.message,
          ),
        ]
    );
  }


}
