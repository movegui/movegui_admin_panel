 

class RecipeIngredient {
  final int id, recipeId, categoryId;
  final DateTime createdAt;


  RecipeIngredient({
    required this.id,
    required this.recipeId,
    required this.categoryId,
    required this.createdAt
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'recipeId': recipeId,
    'categoryid': categoryId,
    'createdAt': createdAt
  };

  factory  RecipeIngredient.fromJson(Map<String, dynamic> json) => RecipeIngredient (
    id: json['id'],
    categoryId: json['categoryId'],
    recipeId: json['recipeId'],
    createdAt: json['createdAt']
  );



}