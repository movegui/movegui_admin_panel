import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';

class ProfessionnelModel extends Model {
  final List<PersonModel> persons;
  final List<String> professions;
  final String description; // imageUrl;
  //final List<String> skills;

  ProfessionnelModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.professions,
    required this.description,
    //  required this.imageUrl,
    //  required this.skills,
    required this.persons,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'description': description,
    'categorie': professions,
    //  'imageUrl': imageUrl,
    //  'skills': skills,
    'persons': persons.map((person) {
      return person.toJson();
    }).toList(),
  };

  factory ProfessionnelModel.fromJson(Map<String, dynamic> json) =>
      ProfessionnelModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        description: json['description'] ?? '',
        //  imageUrl: json['imageUrl'],
        professions: json['professions'] ?? [],
        //     skills: List<String>.from(json['skills'] ?? []),
        persons: (json['persons'] as List? ?? [])
            .map((e) => PersonModel.fromJson(e))
            .toList(),
      );

  @override
  String toString() {
    return 'Profession(name: $name, professions: ${professions[0].toString()}, persons: ${persons.toList().toString()})';
  }
}

class ProfessionCategory {
  final int id;
  final String name;
  final List<String> subCategories;

  ProfessionCategory({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'subCategories': subCategories,
  };

  factory ProfessionCategory.fromJson(Map<String, dynamic> json) =>
      ProfessionCategory(
        id: json['id'],
        name: json['name'],
        subCategories: List<String>.from(json['subCategories']),
      );
}
