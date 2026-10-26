import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/incomplete_module_configuration_model.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_incomplet_tab_row_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_incomplete_tab_header.dart';

class PressingIncompleteDisplayWidget<S extends StoreModel> extends StatelessWidget {
 final List<IncompleteModuleConfigurationModel<S>>  items;

  const PressingIncompleteDisplayWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {

   return Card(
      child: Column(
        children: [
          PressingIncompleteTabHeader(),
          ...items.map((pressing) => PressingIncompletTabRowWidget(moduleItem: pressing,))

        ],
      ),
    );
    
  }
  
}