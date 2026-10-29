abstract class Model {
  final String id;
  final String name;
  final DateTime createdAt;
  final String? description;
  bool? isActive;
  String? iconName;
  String? colorValue;

  Model({
    required this.id,
    required this.name,
    required this.createdAt,
    this.description,
    this.isActive,
    this.iconName,
    this.colorValue
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt,
    'description': description ?? '',
    'isActive': isActive ?? false,
    'iconName': iconName,
    'colorValue': colorValue
  };
}
