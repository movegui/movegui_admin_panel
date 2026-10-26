import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/module_configuration_item_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/module_configuration_card.dart';
import 'package:movegui_admin_panel/widgets/section_header_widget.dart';

class ModuleConfigurationWidget extends StatelessWidget {
  const ModuleConfigurationWidget({
    super.key,
    this.onManagePressings,
    this.onConfigureServices,
    this.onConfigureOpeningHours,
    this.onConfigureDelivery,
    required this.modules,
  });

  final VoidCallback? onManagePressings;
  final VoidCallback? onConfigureServices;
  final VoidCallback? onConfigureOpeningHours;
  final VoidCallback? onConfigureDelivery;
  final List<ModuleConfigurationItemModel> modules;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: AppLocalizations.of(context)!.module_configuration_title,
          subtitle: AppLocalizations.of(context)!.module_configuration_subtitle,
        ),

        SizedBox(height: WidgetConstants.sepWidget),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 12.0;
            int columns;
            Responsive.isDesktop(context) ? columns = 4 : columns = 1;
            final width =
                (constraints.maxWidth - (spacing * (columns - 1))) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final module in modules)
                  SizedBox(
                    width: width,
                    child: ModuleConfigurationCard(module: module),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
