import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_tab_header_widget.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_tab_row_widget.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class PressingServiceTypeDisplayWidget extends StatelessWidget {
  final PressingServiceTypeModel serviceType;
  final List<PressingServiceModel> services;
  final Color primaryColor;
  final VoidCallback onAdd;
  final ValueChanged<PressingServiceModel> onEdit;
  final ValueChanged<PressingServiceModel> onDelete;
  final ValueChanged<PressingServiceModel> onChangeStatus;

  const PressingServiceTypeDisplayWidget({
    super.key,
    required this.serviceType,
    required this.services,
    required this.primaryColor,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.onChangeStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withValues(alpha: .10)),
      ),
      child: Column(
        children: [
          _buildHeader(context),

          const Divider(height: 1),

          PressingServiceTabHeaderWidget(),

          const Divider(height: 1),

          ...services.map(
            (service) => PressingServiceTabRowWidget(
              service: service,
              onEdit: onEdit,
              onDelete: onDelete,
              onChangeStatus: onChangeStatus,
            ),
          ),

          const Divider(height: 1),

          //     _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.local_laundry_service_outlined,
              color: primaryColor,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceType.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        serviceType.description ?? '',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: WidgetConstants.sepWidget),
                    ],
                  ),
                ),
                ButtonWidget(
                  onPressed: (item) async {
                    onAdd.call();
                  },
                  buttonItem: ButtonInfo(
                    title: AppLocalizations.of(context)!.btn_create,
                    enabled: true,
                  ),
                  icon: Icon(Icons.add),
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





}
