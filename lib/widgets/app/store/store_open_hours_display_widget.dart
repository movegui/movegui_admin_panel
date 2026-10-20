import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_open_hours_list_widget.dart';

class StoreOpenHoursDisplayWidget extends StatefulWidget {
  const StoreOpenHoursDisplayWidget({
    super.key,
    required this.openingHours,
    required this.openingHoursChanged,
    required this.title,
    required this.subTitle,
    required this.onRegister,
  });
  final List<OpenHoursModel> openingHours;
  final Function(List<OpenHoursModel>) openingHoursChanged;
  final String title;
  final String subTitle;
  final void Function(List<OpenHoursModel>? openingHours) onRegister;

  @override
  State<StoreOpenHoursDisplayWidget> createState() =>
      StoreOpenHoursDisplayWidgetState();
}

class StoreOpenHoursDisplayWidgetState
    extends State<StoreOpenHoursDisplayWidget> {
  List<OpenHoursModel> openingHours = const [];
  bool _hasInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_hasInitialized) return;
    _hasInitialized = true;

    openingHours = widget.openingHours.isNotEmpty
        ? List<OpenHoursModel>.from(widget.openingHours)
        : _buildDefaultOpeningHours(context);
  }

  List<OpenHoursModel> _buildDefaultOpeningHours(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return [
      localizations.day_lundi,
      localizations.day_mardi,
      localizations.day_mercredi,
      localizations.day_jeudi,
      localizations.day_vendredi,
      localizations.day_samedi,
      localizations.day_dimanche,
    ].map((day) {
      return OpenHoursModel(
        day: day,
        isOpen: false,
        slots: const [
          OpeningTimeSlot(
            openingTime: TimeOfDay(hour: 9, minute: 0),
            closingTime: TimeOfDay(hour: 17, minute: 30),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        DashboardHeader(
          title: widget.title,
          subtitle: widget.subTitle,
          onPressed: (item) async {},
          buttonText: AppLocalizations.of(context)!.btn_create,
          actions: [],
        ),

        const SizedBox(height: 18),
        SingleChildScrollView(
          child: StoreOpenHoursListWidget(
            openingHours: openingHours,
            onHourChanged: (int index, OpenHoursModel value) {
              setState(() {
                openingHours[index] = value;
                widget.onRegister.call(openingHours);
              });
            },
          ),
        ),
      ],
    );
  }
}
