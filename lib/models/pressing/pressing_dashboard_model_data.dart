class PressingDashboardModelData {
  const PressingDashboardModelData({
    required this.totalPressings,
    required this.activePressings,
    required this.inactivePressings,
    required this.configuredServices,
    required this.serviceTypes,
    required this.configuredOpeningHours,
    required this.incompleteOpeningHours,
  });

  final int totalPressings;
  final int activePressings;
  final int inactivePressings;
  final int configuredServices;
  final int serviceTypes;
  final int configuredOpeningHours;
  final int incompleteOpeningHours;

  factory PressingDashboardModelData.empty() {
    return PressingDashboardModelData(
      totalPressings: 0,
      activePressings: 0,
      inactivePressings: 0,
      configuredServices: 0,
      serviceTypes: 0,
      configuredOpeningHours: 0,
      incompleteOpeningHours: 0,
    );
  }
}
