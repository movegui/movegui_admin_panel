abstract class Model {
  final String id;
  final String name;
  final DateTime createdAt;
  final String? description;

  Model({
    required this.id,
    required this.name,
    required this.createdAt,
    this.description
  });

 Map<String, dynamic> toJson() => {
  'id':id,
  'name': name,
  'createdAt': createdAt,
  'description': description ?? ''
};

}