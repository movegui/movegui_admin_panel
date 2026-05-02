import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




class CreateRecettePage extends StatefulWidget {
  const CreateRecettePage({super.key});

  @override
  _CreateRecettePageState createState() => _CreateRecettePageState();
}

class _CreateRecettePageState extends State<CreateRecettePage> {
  final _formKey = GlobalKey<FormState>();

  String recipeName = '';
  double recipePrice = 0;
  String instructions = '';

  // List of ingredient entries
  List<Map<String, dynamic>> ingredients = [{}];

  // Available produits from Firestore
  List<DocumentSnapshot> produits = [];

  @override
  void initState() {
    super.initState();
  //  fetchProduits();
  }

  Future<void> fetchProduits() async {
    final snapshot = await FirebaseFirestore.instance.collection('produits').get();
    setState(() {
      produits = snapshot.docs;
    });
  }

  void addIngredient() {
    setState(() {
      ingredients.add({});
    });
  }

  void removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  Future<void> submitRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recette = {
        'name': recipeName,
        'price': recipePrice,
        'instructions': instructions,
        'ingredients': ingredients
            .where((ing) => ing.containsKey('product_id')) // filter out incomplete
            .map((ing) => {
                  'product_id': ing['product_id'],
                  'name': ing['name'],
                  'quantity': ing['quantity'],
                  'unit': ing['unit'],
                })
            .toList()
      };

   //   await FirebaseFirestore.instance.collection('recettes').add(recette);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recette créée avec succès!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Créer une Recette')),
      body: 
      /*
      produits.isEmpty
          ? Center(child: CircularProgressIndicator())
          : 
          */
          Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nom de la recette'),
                      onChanged: (val) => recipeName = val,
                      validator: (val) => val!.isEmpty ? 'Champ requis' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Prix'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => recipePrice = double.tryParse(val) ?? 0,
                      validator: (val) => val!.isEmpty ? 'Champ requis' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Instructions'),
                      onChanged: (val) => instructions = val,
                      maxLines: 3,
                    ),
                    SizedBox(height: 20),
                    Text('Ingrédients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ...ingredients.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> ingredient = entry.value;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              DropdownButtonFormField(
                                value: ingredient['product_id'],
                                items: produits.map((prod) {
                                  final data = prod.data() as Map<String, dynamic>;
                                  return DropdownMenuItem(
                                    value: prod.id,
                                    child: Text(data['name']),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  final selected = produits.firstWhere((p) => p.id == val);
                                  final data = selected.data() as Map<String, dynamic>;
                                  setState(() {
                                    ingredients[index] = {
                                      ...ingredients[index],
                                      'product_id': selected.id,
                                      'name': data['name'],
                                      'unit': data['unit'],
                                    };
                                  });
                                },
                                hint: Text('Choisir un produit'),
                                validator: (val) => val == null ? 'Sélection requise' : null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Quantité'),
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  ingredients[index]['quantity'] = double.tryParse(val) ?? 0;
                                },
                              ),
                              Text('Unité: ${ingredient['unit'] ?? '-'}'),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => removeIngredient(index),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                    ElevatedButton(
                      onPressed: addIngredient,
                      child: Text('+ Ajouter un ingrédient'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitRecipe,
                      child: Text('Créer la recette'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}



/*

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});


  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Responsive.isDesktop(context) ? AdminPanelAppBarDesktop(title: 'Recettes') : AdminPanelAppBar(title: 'Recettes'),
        drawer: const SideMenu(),
        body: Builder(
        builder: (context) => SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              const Expanded(
                flex: 5,
                child: RecipePage(),
              ),
            ],
          ),
        ),
      )),
    );
  }
  
}

class RecipePage extends StatelessWidget {

  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('In Implementation..............'),
    );
  }
  
}

*/