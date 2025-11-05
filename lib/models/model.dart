abstract class Model {
  final String id;
  final String name;
  final DateTime createdAt;

  Model({
    required this.id,
    required this.name,
    required this.createdAt
  });

 Map<String, dynamic> toJson() => {
  'id':id,
  'name': name,
  'createdAt': createdAt
};

}