
import 'package:flutter/material.dart';



/*
class AddSuppliersWidget extends MainScreen {
  const AddSuppliersWidget({super.key, required super.pageScreen});
}
*/

class SupplierAddWidgetPage extends StatefulWidget {

  const SupplierAddWidgetPage({super.key});
  final String collectionName = 'suppliers';

  @override
  SuppliersUploaWidgetdstate createState() => SuppliersUploaWidgetdstate();
}

class SuppliersUploaWidgetdstate extends State<SupplierAddWidgetPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

/*

 final formController = StoreFormController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<AddContactWidgetState> addContactKey = GlobalKey();
  final GlobalKey<WeeklyHoursScreenState> addOpenHoursKey = GlobalKey();
  bool isLoading = false;
  late SuppliersService suppliersService;
  late RestaurantTypeService restaurantTypeService;
  late SupplierConstants supplierConstants;

  @override
  void initState() {
    suppliersService = getIt<SuppliersService>();
    restaurantTypeService = getIt<RestaurantTypeService>();
    supplierConstants = SupplierConstants();
    super.initState();
  }

  late final submitHandler = SupplierSubmitHandler(
    service: suppliersService,
    imageService: ImageService(),
    collectionName: widget.collectionName,
  );

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
           formController.contacts = await addContactKey.currentState!.getContacts();
      //  formController.weeklyHours = await addOpenHoursKey.currentState!.getOpenHours();
      if (formController.weeklyHours.isNotEmpty &&
          formController.contacts.isNotEmpty &&
          formController.selectedType != null) {
        print('jetz drin ......................');
        await submitHandler.submit(form: formController);
        showAlertBar(context, supplierConstants.getSaveSuccessText(context));
        addContactKey.currentState!.clear();
        addOpenHoursKey.currentState!.resetOpenHours();
        formController.clear();
        /*
        formController.dispose();
        addContactKey.currentState!.dispose();
        */
      }
    } catch (e) {
      showBtmAlert(context, e.toString());
    }

    setState(() => isLoading = false);
  }

  void pickAnImage() async {
   final result = await ImageService.pickAnImage();
   if(result == null){
     showBtmAlert(context, supplierConstants.getImageSelectionText());
    return;
   }
     setState(() {
    formController.pickedImage = result['file'];
    formController.webImage = result["webImage"];
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SizedBox(
                    width: 400,
                    child: CustomDropDown(
                      onChanged: (RestaurantTypeModel type) =>
                          formController.selectedType = type,
                      service: restaurantTypeService,
                      title: 'Types Fournisseurs',
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: supplierConstants,
                    nameController: formController.name,
                    adresseController: formController.adresse,
                    telephonController: formController.telephon,
                    emailController: formController.email,
                    descriptionController: formController.description,
                    nameFocus: formController.nameFocus,
                    descriptionFocus: formController.descriptionFocus,
                    adresseFocus: formController.adresseFocus,
                    emailFocus: formController.emailFocus,
                    telephonFocus: formController.telephonFocus,
                    webImage: formController.webImage,
                    pickedImage: formController.pickedImage,
                    onPickImage: pickAnImage,
                    onRemoveImage: () {
                      setState(() {
                        formController.pickedImage = null;
                        formController.webImage = null;
                      });
                    },
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AddContactWidget(
                    key: addContactKey,
                            onContactsChanged: (contacts) {
                      setState(() {
                        formController.contacts = contacts;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: OpenHoursWidget(
                    key: addOpenHoursKey,
                    onHoursChanged: (hours) {
                      setState(() {
                        print(
                          'hours is: ${hours.map((e) => (e.closeTime != null && e.openTime != null) ? e.toJson() : {}).toList()}',
                        );
                        formController.weeklyHours = hours; // Or whatever handling you want
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButon(
                    text: "Enregistrer",
                    icon: Icons.save,
                    onTap: _onSubmit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  */
}
