import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/services/interfaces/i_pressing_services.dart';
import 'package:movegui_admin_panel/services/model_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';

class PressingService extends ModelService<PressingModel>
    implements IPressingServices {
  PressingService({required super.api});

  @override
  Future<PressingModel> addModel(PressingModel pressing) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(pressing.id)
        .set(pressing.toJson());
    return pressing;
  }

  @override
  Future<List<PressingModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();

    return snapshot.docs
        .map((doc) => PressingModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<PressingModel>> getByName(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('name', isEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => PressingModel.fromJson(doc.data()))
        .toList();
  }

  @override
  String getCollectionName() {
    return "pressings_model";
  }

  Future<PressingModel> addServices(
    PressingModel pressing,
    List<PressingServiceModel>? services,
  ) async {
    for (final service in services!) {
      await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(pressing.id)
          .collection(service.getCollectionName())
          .doc(service.id)
          .set(service.toJson());
    }
    return pressing;
  }

  @override
  Future<List<PressingServiceModel>> getAllServices(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .collection('services')
        .get();
    return snapshot.docs
        .map((doc) => PressingServiceModel.fromJson(doc.data()))
        .toList();
  }

  List<PressingServiceModel> getServicesByType(
    List<PressingServiceModel> services,
    PressingServiceTypeModel? selectedServiceType,
  ) {
    return services
        .where((service) => service.serviceType.id == selectedServiceType?.id)
        .toList();
  }

  @override
  Future<PressingModel> getModelById(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();
    return PressingModel.fromJson(snapshot.data()!);
  }

  @override
  Future<void> deleteModel(PressingModel pressing) async {
    final userService = getIt<UserService>();
    final services = await getAllServices(pressing.id);
    await deleteServices(pressing, services);
    pressing.staff?.map((user) async => await  userService.deleteModel(user)) ?? [];
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(pressing.id)
        .delete();
  }


  @override
  Future<void> deleteServices(
    PressingModel pressing,
    List<PressingServiceModel>? services,
  ) async {
    for (final service in services!) {
      await FirebaseFirestore.instance
          .collection(getCollectionName())
          .doc(pressing.id)
          .collection(service.getCollectionName())
          .doc(service.id)
          .delete();
    }
  }
}
