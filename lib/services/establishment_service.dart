import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/exception/app_exception.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_members_model.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/service_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/establishment_members_service.dart';
import 'package:movegui_admin_panel/services/model_service.dart';
import 'package:movegui_admin_panel/services/user_service.dart';

abstract class EstablishmentService<
  M extends EstablishmentModel,
  S extends ServiceModel
>
    extends ModelService<M> {
  EstablishmentService({
    required super.api,
    required super.fromJson,
    required this.establishmentMembersService,
    required this.userService,
    this.fromJsonService,
  });
  final S Function(Map<String, dynamic> json)? fromJsonService;
  final EstablishmentMembersService establishmentMembersService;
  final UserService userService;


  Future<M> addServices(M model, List<S>? services) async {
    for (final service in services!) {
      await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(model.id)
          .collection(MoveGuiCollections.COLLECTION_ESTABLISHMENTS_SERVICES)
          .doc(service.id)
          .set(service.toJson());
    }
    return model;
  }

  Future<List<S>> getAllServices(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .collection('services')
        .get();
    return snapshot.docs
        .map((doc) => fromJsonService!({...doc.data(), 'id': doc.id}))
        .toList();
  }

  Future<void> deleteServices(M model, List<S>? services) async {
    for (final service in services!) {
      await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(model.id)
          .collection(MoveGuiCollections.COLLECTION_ESTABLISHMENTS_SERVICES)
          .doc(service.id)
          .delete();
    }
  }

  Future<List<UserModel>?> getStaff(M model) async {
    final members = await establishmentMembersService.getMembers(model.id);
    final staff = await Future.wait(
      members.map((member) async {
        try {
          return await userService.getModelById(member.userId);
        } on NotDataFoundException {
          print(
            'Skipping establishment member ${member.id}: '
            'user ${member.userId} was not found.',
          );
          return null;
        }
      }),
    );
    return staff.whereType<UserModel>().toList();
  }
}
