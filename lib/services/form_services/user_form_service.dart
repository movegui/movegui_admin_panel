import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/form_services/form_service.dart';
import 'package:movegui_admin_panel/services/form_services/person_form_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/util/user_form_controller.dart';
import 'package:uuid/uuid.dart';

class UserFormService extends FormService<UserModel, UserFormController> {
  UserFormService({
    required this.personFormService,
    required super.api,
    required super.controllerFactory,
    required super.seedService,
  });
  final PersonFormService personFormService;

  @override
  UserModel getDefaultModel() {
    return UserModel(
      updatedAt: DateTime.now(),
      id: Uuid().v4(),
      name: 'default',
      createdAt: DateTime.now(),
      username: 'default',
      isVerified: false,
      role: UserRole.Guest,
      personModel: personFormService.getDefaultModel(),
    );
  }

  @override
  Future<UserModel> getModel(UserFormController controller) async {
    return UserModel(
      updatedAt: DateTime.now(),
      id: Uuid().v4(),
      name: '',
      createdAt: controller.createdAt ?? DateTime.now(),
      username: controller.username.text,
      isVerified: controller.isVerified ?? false,
      role: UserRole.Guest,
      isActive: controller.isActive ?? false,
      personModel: await personFormService.getModel(controller.personForm),
    );
  }

  @override
  Future<UserModel> generateModel() {
    return seedService.getGeneratedUserModel();
  }
}
