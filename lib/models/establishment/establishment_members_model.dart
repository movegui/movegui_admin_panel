import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/model.dart';

class EstablishmentMembersModel extends Model {
  final String userId;
  final String storeId;
  final EstablishmentType establishmentType;
  final List<EstablishmentRole> roles;
  final bool? isVerified;

  EstablishmentMembersModel({
    required this.userId,
    required this.storeId,
    required this.establishmentType,
    required this.roles,
    required super.id,
    required super.name,
    required super.createdAt,
    required super.isActive,
    required this.isVerified
    
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'userId': userId,
    'storeId': storeId,
    'establishmentType': establishmentType.toJson(),
    'roles': roles.map((role) => role.name).toList(),
    'isVerified': isVerified

  };

  factory EstablishmentMembersModel.fromJson(Map<String, dynamic> json) {
    final rawStoreType = json['establishmentType'];
    final String normalizedStoreTypeId = rawStoreType is Map
        ? (rawStoreType['id'] as String? ??
              rawStoreType['name'] as String? ??
              'other')
        : (rawStoreType is String ? rawStoreType : 'other');

    return EstablishmentMembersModel(
      userId: json['userId'],
      storeId: json['storeId'],
      establishmentType: EstablishmentType.values.firstWhere(
        (store) =>
            store.id == normalizedStoreTypeId ||
            store.name == normalizedStoreTypeId,
        orElse: () => EstablishmentType.other,
      ),
      roles: json['roles'] != null
          ? (json['roles'] as List)
                .map<EstablishmentRole>(
                  (role) => EstablishmentRole.values.firstWhere(
                    (elem) => elem.name == role,
                  ),
                )
                .toList()
          : <EstablishmentRole>[],
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
      isActive: json['isActive'] ?? false,
      isVerified: json['isVerified'] ?? false
    );
  }
}
