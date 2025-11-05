
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/super_markt_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/super_markts_service.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:uuid/uuid.dart';

class SuperMarktAddWidgetPage extends StatefulWidget {
  const SuperMarktAddWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => SuperMarktAddWidgetPageState();
  
}

class SuperMarktAddWidgetPageState extends State<SuperMarktAddWidgetPage> {
 
  GlobalKey<FormState> formKey = GlobalKey();
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

  late SuperMarktsService superMarktsService;
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
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     superMarktsService = getIt<SuperMarktsService>();
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
  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;

    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'Ajouter un Super Marché')
          : AdminPanelAppBar(title: 'Ajouter un Super Marché'),
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
                                  'Ajouter un Super Marché:',
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
                                        ? Size.width * 0.4
                                        : Size.width * 0.5,
                                    child: Column(
                                      children: [
                                        /*
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Restaurant Type: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            SizedBox(width: 25),
                                            CustomDropDown(
                                              service: restaurantTypeService,
                                              onChanged:
                                                  (
                                                    RestaurantTypeModel
                                                    newValue,
                                                  ) => {
                                                    selectedRestaurantType =
                                                        newValue,
                                                  },
                                            ),
                                          ],
                                        ),
                                        */

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CustomTextField(
                                                    hasIcon: false,
                                                    hintText:
                                                        'Veuillez saisir le nom du Super Marché',
                                                    isNumber: false,
                                                    controller: _nameController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    inputType:
                                                        TextInputType.name,
                                                    nextFocusNode:
                                                        _descriptionFocusNode,
                                                    labelText:
                                                        'Nom du Super Marché',
                                                    icon: Icons.home,
                                                    /*
                                                    onChanged: (data) {
                                                      name = data.trim();
                                                    },
                                                    */
                                                    validator: (value) {
                                                      return MyValidators.textNameValidator(
                                                        value,
                                                      );
                                                    },
                                                  ),

                                                  CustomTextField(
                                                    hasIcon: false,
                                                    hintText:
                                                        'Veuillez saisir la description du Super Marché',
                                                    isNumber: false,
                                                    controller:
                                                        _descriptionController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    inputType:
                                                        TextInputType.multiline,
                                                        maxLines: 5,
                                                    nextFocusNode:
                                                        _adresseFocusNode,
                                                    labelText:
                                                        ' Description du Super Marché',
                                                    icon: Icons.info,
                                                    /*
                                                      onChanged: (data) {
                                                        name = data.trim();
                                                      },
                                                      */
                                                    validator: (value) {
                                                      return MyValidators.textValidator(
                                                        value,
                                                      );
                                                    },
                                                  ),

                                                  CustomTextField(
                                                    hasIcon: false,
                                                    hintText:
                                                        'Veuillez saisir l\'adresse du Super Marché',
                                                    isNumber: false,
                                                    controller:
                                                        _adresseController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    inputType:
                                                        TextInputType.name,
                                                    nextFocusNode:
                                                        _emailFocusNode,
                                                    labelText:
                                                        ' l\'adresse du Super Marché',
                                                    icon: Icons.home,
                                                    /*
                                                      onChanged: (data) {
                                                        name = data.trim();
                                                      },
                                                      */
                                                    validator: (value) {
                                                      return MyValidators.textValidator(
                                                        value,
                                                      );
                                                    },
                                                  ),
                                                  CustomTextField(
                                                    hasIcon: false,
                                                    hintText:
                                                        'Veuillez saisir l\'email du Super Marché',
                                                    isNumber: false,
                                                    controller:
                                                        _emailController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    inputType:
                                                        TextInputType.name,
                                                    nextFocusNode:
                                                        _telephonFocusNode,
                                                    labelText:
                                                        ' l\'email du Super Marché',
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
                                                        'Veuillez saisir le telephone du Super Marché',
                                                    isNumber: false,
                                                    controller:
                                                        _telephonController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    inputType:
                                                        TextInputType.name,
                                                    nextFocusNode:
                                                        _contactFocusNode,
                                                    labelText:
                                                        ' le telephone du Super Marché',
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
                                                        'Veuillez saisir la personne de Contact du Super Marché',
                                                    isNumber: false,
                                                    controller:
                                                        _contactController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    inputType:
                                                        TextInputType.name,
                                                    labelText:
                                                        ' Personne de contact',
                                                    icon: Icons.person,

                                                    /*
                                                    onChanged: (data) {
                                                      name = data.trim();
                                                    },
                                                    */
                                                    validator: (value) {
                                                      return MyValidators.textValidator(
                                                        value,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(width: Size.width * 0.03),

                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                width: 250,
                                                height: 300,
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.35),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: _pickedImage != null
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            child: kIsWeb
                                                                ? Image.memory(
                                                                    webImage,
                                                                    width: 240,
                                                                    height: 220,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )
                                                                : Image.file(
                                                                    _pickedImage!,
                                                                    width: 180,
                                                                    height: 120,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                _pickedImage =
                                                                    null;
                                                                webImage =
                                                                    Uint8List(
                                                                      8,
                                                                    );
                                                              });
                                                            },
                                                            child: const Text(
                                                              'supprimer image',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                _pickImage,
                                                            child: const Text(
                                                              'choisir Image',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            onPressed:
                                                                _pickImage,
                                                            icon: const Icon(
                                                              Icons
                                                                  .image_outlined,
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Column(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      'Choisir image',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            FontSize,
                                                                        color: AppColors
                                                                            .textColor,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                      if (_pickedImage != null) {
                                        String? imageUrl =
                                            await _uploadImageToFirebase();
                                           
                                        if (imageUrl != null) {
                                          final superMarkt = SuperMarktModel(
                                            id: _uuid,
                                            name: _nameController.text,
                                            createdAt: DateTime.now(),
                                            description:
                                                _descriptionController.text,
                                            adresse: _adresseController.text,
                                            telephon: _telephonController.text,
                                            email: _emailController.text,
                                            contact: _contactController.text,
                                            imageUrl: imageUrl,
                                          
                                          );
                                              superMarktsService.addModel(superMarkt);

                                          setState(() {
                                            _nameController.clear();
                                            _adresseController.clear();
                                            _telephonController.clear();
                                            _emailController.clear();
                                            _contactController.clear();
                                            _companyController.clear();
                                            _typeController.clear();
                                            _nameFocusNode.requestFocus();
                                            _descriptionController.clear();
                                          });
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          showAlertBar(
                                            context,
                                            'Nouveau Super Marché Ajouter avec succes!',
                                          );
                                        }
                                      } else {
                                        showBtmAlert(
                                          context,
                                          "veillez choisir une image pour le Super Marché !!!",
                                        );
                                      }
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
        showBtmAlert(context, 'Veuillez choisir une Image');
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
        showBtmAlert(context, 'Veuillez choisir une Image');
      }
    } else {
      showBtmAlert(context, 'Un problème est survenu !!!');
    }
  }

  Future<String?> _uploadImageToFirebase() async {
    try {
      final storage = FirebaseStorage.instance;

      // Create a unique file name
      String fileName = 'superMarkts/${DateTime.now().millisecondsSinceEpoch}.jpg';
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
  
}