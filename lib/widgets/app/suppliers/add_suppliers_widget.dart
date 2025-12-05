import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/supplier_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/services/suppliers_service.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/app/opens_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_drop_down.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:movegui_admin_panel/widgets/store_widget.dart';
import 'package:uuid/uuid.dart';

/*
class AddSuppliersWidget extends MainScreen {
  const AddSuppliersWidget({super.key, required super.pageScreen});
}
*/

class SupplierAddWidgetPage extends StatefulWidget {
  const SupplierAddWidgetPage({super.key});

  @override
  SuppliersUploaWidgetdstate createState() => SuppliersUploaWidgetdstate();
}

class SuppliersUploaWidgetdstate extends State<SupplierAddWidgetPage> {
  GlobalKey<FormState> formKey = GlobalKey();
    final GlobalKey<AddContactWidgetState> _contactWidgetKey =
      GlobalKey<AddContactWidgetState>();

 late RestaurantsService restaurantsService;
  late RestaurantTypeService restaurantTypeService;

  double? price;
  String dropdownValue = 'vegetable';
  int? _selectedValue = 1;
  String unit = "KG";
  bool _isLoading = false;
  double? salePrice;
  bool showTextForm = false;
  bool isOnSale = false;
  late SuppliersService suppliersService;
  late TextEditingController _nameController;
  late TextEditingController _adresseController;
  late TextEditingController _telephonController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  late TextEditingController _companyController;
  late TextEditingController _typeController;
  late TextEditingController _descriptionController;

  late FocusNode _nameFocusNode;
  late FocusNode _adresseFocusNode;
  late FocusNode _telephonFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _contactFocusNode;
  late FocusNode _companyFocusNode;
  late FocusNode _typeFocusNode;
  late FocusNode _descriptionFocusNode;
    Uint8List webImage = Uint8List(8);
  File? _pickedImage;
  late List<OpenHours> weeklyHours;
  late RestaurantTypeModel selectedRestaurantType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suppliersService =  getIt<SuppliersService>();//SuppliersService();
    _nameController = TextEditingController();
    _adresseController = TextEditingController();
    _telephonController = TextEditingController();
    _emailController = TextEditingController();
    _contactController = TextEditingController();
    _companyController = TextEditingController();
    _typeController = TextEditingController();
    _descriptionController = TextEditingController();


    _nameFocusNode = FocusNode();
    _adresseFocusNode = FocusNode();
    _telephonFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _contactFocusNode = FocusNode();
    _companyFocusNode = FocusNode();
    _typeFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    weeklyHours = [];
  }

    @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;

    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'Ajouter un Restaurant')
          : AdminPanelAppBar(title: 'Ajouter un Restaurant'),
      drawer: SideMenu(),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: _buildFormContent(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

    Widget _buildFormContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double fontSize = size.width < 600 ? 18 : 28;

    return Center(
      child: Container(
        width: size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.backgroundColor,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ajouter un Restaurant:',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: AppColors.textColor,
                    decorationColor: AppColors.textColor,
                  ),
                ),
              ),

              /// Restaurant type dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Responsive.isDesktop(context)
                        ? size.width * 0.4
                        : size.width * 0.5,
                    child: Column(
                      children: [
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text(
                              'Restaurant Type: ',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textColor,
                              ),
                            ),
                            const SizedBox(width: 25),
                            CustomDropDown(
                              service: restaurantTypeService,
                              onChanged: (RestaurantTypeModel newValue) {
                                selectedRestaurantType = newValue;
                              },
                            ),
                          ],
                        ),
                        
                        

                        /// Main StoreWidget fields
                        StoreWidget(
                          nameController: _nameController,
                          descriptionController: _descriptionController,
                          adresseController: _adresseController,
                          emailController: _emailController,
                          telephonController: _telephonController,
                          nameFocus: _nameFocusNode,
                          descriptionFocus: _descriptionFocusNode,
                          adresseFocus: _adresseFocusNode,
                          emailFocus: _emailFocusNode,
                          telephonFocus: _telephonFocusNode,

                          pickedImage: _pickedImage,
                          webImage: webImage,
                          onPickImage: _pickImage,
                          onRemoveImage: () {
                            setState(() {
                              _pickedImage = null;
                              webImage = Uint8List(8);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// Contacts
              AddContactWidget(key: _contactWidgetKey),

              const SizedBox(height: 12),

              /// Open hours
              OpenHoursWidget(
                onHoursChanged: (hours) {
                  setState(() {
                    print(
                      'hours is: ${hours.map((e) => (e.closeTime != null && e.openTime != null) ? e.toJson() : {}).toList()}',
                    );
                    weeklyHours = hours; // Or whatever handling you want
                  });
                },
              ),

              const SizedBox(height: 25),

              /// Save button
              CustomButon(
                text: 'Enregistrer',
                icon: Icons.upload,
                onTap: _onSubmitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

    Future<void> _onSubmitForm() async {
    setState(() => _isLoading = true);
    final form = formKey.currentState;
    if (form == null || !form.validate()) {
      setState(() => _isLoading = false);
      return;
    }
    form.save();
    List<PersonModel> contacts =
        await _contactWidgetKey.currentState?.getContacts() ?? <PersonModel>[];
    if (_pickedImage == null) {
      showBtmAlert(
        context,
        "Veuillez choisir une image pour le restaurant !!!",
      );
      setState(() => _isLoading = false);
      return;
    }

    if (contacts.isEmpty) {
      showBtmAlert(context, "Veuillez ajouter au moins un gerant !!!");
      setState(() => _isLoading = false);
      return;
    }

    if (weeklyHours.isEmpty) {
      showBtmAlert(context, "Veuillez ajouter au moins un jour ouvrable !!! ");
      setState(() => _isLoading = false);
      return;
    }

    try {
      final imageUrl = await _uploadImageToFirebase();
      if (imageUrl == null) throw Exception("Image upload failed");

      final id = const Uuid().v4();

      final restaurant = SupplierModel(
        id: id,
        name: _nameController.text,
        createdAt: DateTime.now(),
        description: _descriptionController.text,
        adresse: _adresseController.text,
        telephon: _telephonController.text,
        email: _emailController.text,
        contacts: contacts,
        imageUrl: imageUrl,
        storeType: selectedRestaurantType,
        weeklyHours: weeklyHours,
      );

      print("Restaurant: ${restaurant.toJson().toString()}");

      // Clear form
      _nameController.clear();
      _adresseController.clear();
      _telephonController.clear();
      _emailController.clear();
      _descriptionController.clear();
      _nameFocusNode.requestFocus();

      showAlertBar(context, 'Nouveau Restaurant ajouté avec succès!');
    } catch (e) {
      showBtmAlert(context, e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

    Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        showBtmAlert(context, 'please select an image');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        showBtmAlert(context, 'please select an image');
      }
    } else {
      showBtmAlert(context, 'Something went wrong');
    }
  }

    Future<String?> _uploadImageToFirebase() async {
    try {
      final storage = FirebaseStorage.instance;

      // Create a unique file name
      String fileName =
          'restaurant/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = storage.ref().child(fileName);

      UploadTask uploadTask;

      if (kIsWeb) {
        // Upload bytes for web
        UploadTask uploadTask = ref.putData(
          webImage!, // from your _pickImage()
          SettableMetadata(contentType: 'image/jpeg'),
        );
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        // Upload file for mobile
        UploadTask uploadTask = ref.putFile(
          _pickedImage!,
          SettableMetadata(contentType: 'image/jpeg'),
        );
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }



/*
  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;

    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'Ajouter une categorie')
          : AdminPanelAppBar(title: 'Ajouter une categorie'),
      drawer: SideMenu(),
      body: Builder(
        builder: (context) => SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
              if (Responsive.isDesktop(context))
                const Expanded(child: SideMenu()),
                */
              Expanded(
                flex: 5,
                child: ModalProgressHUD(
                  inAsyncCall: _isLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Container(
                        width: Size.width * 0.4,
                        //   height: Size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors
                              .backgroundColor, //Colors.grey.withOpacity(0.3),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Ajouter un Fournisseur:',
                                  style: TextStyle(
                                    fontSize: FontSize,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: AppColors.textColor,
                                    decorationColor: AppColors.textColor,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Responsive.isDesktop(context)
                                        ? Size.width * 0.3
                                        : Size.width * 0.4,
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir le nom du Fournisseur',
                                          isNumber: false,
                                          controller: _nameController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _companyFocusNode,
                                          labelText: 'Nom du Fournisseur',
                                          icon: Icons.home,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),

                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir l\'entreprise du Fournisseur',
                                          isNumber: false,
                                          controller: _companyController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _typeFocusNode,
                                          labelText: ' l\'entreprise du Fournisseur',
                                          icon: Icons.business_center,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir le type de Fournisseur',
                                          isNumber: false,
                                          controller: _typeController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _adresseFocusNode,
                                          labelText: ' le type de Fournisseur',
                                          icon: Icons.business_sharp,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),

                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir l\'adresse du Fournisseur',
                                          isNumber: false,
                                          controller: _adresseController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _emailFocusNode,
                                          labelText: ' l\'adresse du Fournisseur',
                                          icon: Icons.home,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir l\'email du Fournisseur',
                                          isNumber: false,
                                          controller: _emailController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _telephonFocusNode,
                                          labelText: ' l\'email du Fournisseur',
                                          icon: Icons.email,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            return MyValidators.emailValidator(
                                              value,
                                            );
                                          },
                                        ),
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir le telephone du Fournisseur',
                                          isNumber: false,
                                          controller: _telephonController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _contactFocusNode,
                                          labelText: ' le telephone du Fournisseur',
                                          icon: Icons.phone,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            return MyValidators.phoneNumberValidator(
                                              value,
                                            );
                                          },
                                        ),
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir la personne de Contact du Fournisseur',
                                          isNumber: false,
                                          controller: _contactController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          labelText: ' Personne de contact',
                                          icon: Icons.person,

                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),

                                        SizedBox(width: 6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              CustomButon(
                                text: 'Enregistrer',
                                icon: Icons.upload,
                                onTap: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  String? imageUrl;
                                  final form = formKey.currentState;
                                  if (form != null && form.validate()) {
                                    form.save();
                                    final _uuid = const Uuid().v4();
                                    try {
                                      final supplier = SupplierModel(
                                        id: _uuid,
                                        name: _nameController.text,
                                        createdAt: DateTime.now(),
                                        adresse: _adresseController.text,
                                        telephon: _telephonController.text,
                                        email: _emailController.text,
                                        contact: _contactController.text,
                                        company: _companyController.text,
                                        type: _typeController.text,
                                      );
                                      suppliersService.addModel(supplier);
                                      setState(() {
                                        _nameController.clear();
                                        _adresseController.clear();
                                        _telephonController.clear();
                                        _emailController.clear();
                                        _contactController.clear();
                                        _companyController.clear();
                                        _typeController.clear();
                                        _nameFocusNode.requestFocus();
                                      });
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showAlertBar(
                                        context,
                                        'Nouveau Fournisseur Ajouter avec succes!',
                                      );
                                    } on FirebaseException catch (e) {
                                      showBtmAlert(
                                        context,
                                        e.message.toString(),
                                      );
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  */
}
