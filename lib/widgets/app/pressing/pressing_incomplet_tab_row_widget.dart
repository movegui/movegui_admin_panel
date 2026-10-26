import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/incomplete_module_configuration_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';
import 'package:movegui_admin_panel/widgets/util/display_widget.dart';

class PressingIncompletTabRowWidget extends StatelessWidget {
  final IncompleteModuleConfigurationModel moduleItem;
  const PressingIncompletTabRowWidget({super.key, required this.moduleItem,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.12)),
        ),
      ),
      child: Responsive.isDesktop(context)
          ? buildDesktop(context)
          : buildMobile(context),
    );
  }

  Widget buildDesktop(BuildContext context) {
    return Row(
      children: [
        // SERVICE
        Expanded(
          flex: 12,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: DisplayWidget(
                  text: moduleItem.store.name ?? '',
                  textAlign: TextAlign.left,
                ),
              ),

              Expanded(flex: 3, child: DisplayWidget(text: moduleItem.problem)),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: (moduleItem.store.isComplete == true ?? false)
                      ? AppLocalizations.of(context)!.complete
                      : AppLocalizations.of(context)!.incomplete,
                ),
              ),

              Expanded(
                flex: 2,
                child: ButtonWidget(
                  onPressed: (item) async {},
                  buttonItem: ButtonInfo(
                    title: AppLocalizations.of(context)!.btn_configure,
                    enabled: true,
                  ),
                ),
              ),
            ],
          ),
        ),

        // PRIX
      ],
    );
  }

  Widget buildMobile(BuildContext context) {
    return Row(
      children: [
        // SERVICE
        Expanded(
          flex: 12,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: DisplayWidget(
                  text: moduleItem.store.name ?? '',
                  textAlign: TextAlign.left,
                ),
              ),

              Expanded(flex: 2, child: DisplayWidget(text: moduleItem.problem)),

              Expanded(
                flex: 2,
                child: DisplayWidget(
                  text: moduleItem.store.isComplete == true
                      ? AppLocalizations.of(context)!.complete
                      : AppLocalizations.of(context)!.incomplete,
                ),
              ),
            ],
          ),
        ),

        // PRIX
      ],
    );
  }
}
