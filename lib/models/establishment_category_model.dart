import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';

enum EstablishmentCategoryModel {
  pressing_etablishment('etablishment', 'Etablishment', EstablishmentType.pressing),
  other('', '', EstablishmentType.other);

  final EstablishmentType establishmentType;
  final String id;
  final String name;

  const EstablishmentCategoryModel(this.id, this.name, this.establishmentType);

  Map<String, dynamic> toJson() => {
    'storeType': establishmentType.toJson(),
  };

  static EstablishmentCategoryModel fromJson(dynamic json) {
    final rawStoreType = json is Map ? json['storeType'] : json;
    final String normalizedStoreTypeId = rawStoreType is Map
        ? (rawStoreType['id'] as String? ??
              rawStoreType['name'] as String? ??
              'other')
        : (rawStoreType is String ? rawStoreType : 'other');

    final establishmentType = EstablishmentType.values.firstWhere(
      (store) =>
          store.id == normalizedStoreTypeId ||
          store.name == normalizedStoreTypeId,
      orElse: () => EstablishmentType.other,
    );

    return values.firstWhere(
      (category) => category.establishmentType == establishmentType,
      orElse: () => other,
    );
  }
}
