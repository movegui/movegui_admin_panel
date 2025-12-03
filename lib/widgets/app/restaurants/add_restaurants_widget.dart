import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/app/opens_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_drop_down.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:movegui_admin_panel/widgets/store_widget.dart';
import 'package:uuid/uuid.dart';

class RestaurantAddWidgetPage extends StatefulWidget {
  const RestaurantAddWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantsUploaWidgetdstate();
}

class RestaurantsUploaWidgetdstate extends State<RestaurantAddWidgetPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<AddContactWidgetState> _contactWidgetKey =
      GlobalKey<AddContactWidgetState>();
  late List<OpenHours> weeklyHours;
  double? price;
  String dropdownValue = 'vegetable';
  int? _selectedValue = 1;
  String unit = "KG";
  bool _isLoading = false;
  double? salePrice;
  bool showTextForm = false;
  bool isOnSale = false;
  Uint8List webImage = Uint8List(8);
  File? _pickedImage;

  late RestaurantsService restaurantsService;
  late RestaurantTypeService restaurantTypeService;
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

  late RestaurantTypeModel selectedRestaurantType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restaurantsService = getIt<RestaurantsService>(); //SuppliersService();
    restaurantTypeService = getIt<RestaurantTypeService>();
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

      final restaurant = RestaurantModel(
        id: id,
        name: _nameController.text,
        createdAt: DateTime.now(),
        description: _descriptionController.text,
        adresse: _adresseController.text,
        telephon: _telephonController.text,
        email: _emailController.text,
        contacts: contacts,
        imageUrl: imageUrl,
        restaurantType: selectedRestaurantType,
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
}
