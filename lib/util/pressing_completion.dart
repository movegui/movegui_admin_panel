import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';

abstract final class PressingCompletion {
  static bool isComplete({
    required List<UserModel>? staff,
    required List<PressingServiceModel>? services,
    required List<OpenHoursModel> weeklyHours,
  }) =>
      hasConfiguredStaff(staff) &&
      hasActiveService(services) &&
      hasOpenHours(weeklyHours);

  static bool hasConfiguredStaff(List<UserModel>? staff) =>
      hasRole(staff, UserRole.Owner) &&
      hasRole(staff, UserRole.Manager) &&
      hasRole(staff, UserRole.Employe);

  static bool hasActiveService(List<PressingServiceModel>? services) =>
      services?.any((service) => service.isActive == true) ?? false;

  static bool hasOpenHours(List<OpenHoursModel> weeklyHours) =>
      weeklyHours.any((hour) => hour.isOpen);

  static bool hasConfiguredOpeningHours(List<OpenHoursModel> weeklyHours) =>
      weeklyHours.any((hour) => hour.isOpen && hour.slots.isNotEmpty);

  static bool hasRole(List<UserModel>? staff, UserRole role) =>
      staff?.any((contact) => contact.role == role) ?? false;
}