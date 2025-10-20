abstract class Model {
  final String id;
  final String? name;

  Model({
    required this.id,
    required this.name
  });

 Map<String, dynamic> toJson() => {
  'id':id,
  'name': name
};

}