

/*
class SuperMarktSubmitHandler extends StoreSubmitHadler<SuperMarktModel, SuperMarktsService>{
  final CategoriesModel categoriesModel;
  
  SuperMarktSubmitHandler({
    required super.service,
    required super.imageService,
    required super.collectionName,
    required this.categoriesModel
  });

  
  @override
  Future<void> submit({required StoreFormController form}) async {
    final imageUrl = await imageService.uploadImage(
      file: form.pickedImage,
      webBytes: form.webImage,
      collectionName: collectionName,
    );

    if (imageUrl == null) throw Exception("Image upload failed");

    final restaurant = SuperMarktModel(
      id: const Uuid().v4(),
      name: form.name.text,
      description: form.description.text,
      address: form.adressModel!,
      telephon: form.telephon.text,
      email: form.email.text,
      contacts: form.contacts,
      weeklyHours: form.weeklyHours,
      storeType: form.selectedType!,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      category: categoriesModel
    );

    await service.addModel(restaurant);
  }
}
*/