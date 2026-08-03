

/*
class SupplierSubmitHandler
    extends StoreSubmitHadler<SupplierModel, SuppliersService> {
  SupplierSubmitHandler({
    required super.service,
    required super.imageService,
    required super.collectionName,
  });

  @override
  Future<void> submit({required StoreFormController form}) async {
    final imageUrl = await imageService.uploadImage(
      file: form.pickedImage,
      webBytes: form.webImage,
      collectionName: collectionName,
    );

    if (imageUrl == null) throw Exception("Image upload failed");

    final supplier = SupplierModel(
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
    );

/*
    print('name is: ${supplier.name.toString()}');
    print('***********************************');
    print('descrip is: ${supplier.description.toString()}');
      print('***********************************');
    print('adresse is: ${supplier.adresse.toString()}');
      print('***********************************');
    print('telephone is: ${supplier.telephon.toString()}');
      print('***********************************');
    print('email is: ${supplier.email.toString()}');
      print('***********************************');
    print('storeType is: ${supplier.storeType.toJson().toString()}');
      print('***********************************');
    print('createdAt is: ${supplier.createdAt.toString()}');
      print('***********************************');
    print('contacts is: ${supplier.contacts.map((c) => {c.toJson().toString()}).toList()}');
        print('***********************************');
    print('weekhours is: ${supplier.weeklyHours.map((e) => {e.toJson().toString()}).toList()}');
    */

  // print('supplier is: ${supplier.toJson().toString()}');
      await service.addModel(supplier);
  }
}
*/
