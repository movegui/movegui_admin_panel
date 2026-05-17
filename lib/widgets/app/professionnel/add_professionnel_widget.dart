import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/professions_list.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/professionnel_model.dart';
import 'package:movegui_admin_panel/services/professionnel_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/widgets/add_person_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class ProfessionnelAddWidgetPage extends StatefulWidget {
  const ProfessionnelAddWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => ProfessionnelAddWidgetPageState();
}

class ProfessionnelAddWidgetPageState
    extends State<ProfessionnelAddWidgetPage> {
  final List<ProfessionCategory> categories = professionsCategories
      .map((item) => ProfessionCategory.fromJson(item))
      .toList();

  GlobalKey<FormState> formKey = GlobalKey();
  List<String?> genders = [];
  List<DateTime?> birthdates = [];

  // Store checkbox states
  final Map<String, bool> checkedStates = {};
  bool _isLoading = false;
  // File? _pickedImage;
  late TextEditingController _descriptionController;
  List<Map<PersonModel, dynamic>> persons = [{}];
  List<DocumentSnapshot> produits = [];
  List<String> names = [];
  List<String> selectedProfessions = [];
  List<GlobalKey<FormState>> formKeys = [];
  late List<TextEditingController> firstNamesControllers;
  late List<TextEditingController> lastNamesNameControllers;
  late List<TextEditingController> surnamesControllers;
  late List<TextEditingController> middleNamesControllers;
  // late List<TextEditingController> profileImageUrlsControllers;
  late List<TextEditingController> emailsControllers;
  late List<TextEditingController> phonesControllers;
  late List<TextEditingController> gendersControllers;
  late List<TextEditingController> birthdatesControllers;
  late List<TextEditingController> addressesControllers;
  late List<TextEditingController> quartierControllers;
  late ProfessionnelService professionnelService;
  late List<File?> personImages;
  late Uint8List? webImage;
  late File? pickedImage;
  late ImageConstatnt imageConstatnt;
  String? selectAdresseType;
  String? selectCommune;

  // late PressingService pressingService;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    firstNamesControllers = [];
    lastNamesNameControllers = [];
    surnamesControllers = [];
    middleNamesControllers = [];
    // profileImageUrlsControllers = [];
    emailsControllers = [];
    phonesControllers = [];
    gendersControllers = [];
    birthdatesControllers = [];
    addressesControllers = [];
    professionnelService = getIt<ProfessionnelService>();
    personImages = [];
    genders.add('Homme');
    quartierControllers = [];
    selectAdresseType = 'h';
    selectCommune = 'di';
  }

  Future<void> fetchProduits() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('produits')
        .get();
    setState(() {
      produits = snapshot.docs;
    });
  }

  void addIngredient() {
    setState(() {
      persons.add({});
    });
  }

  void removeIngredient(index) {
    setState(() {
      if (persons.length > 1) {
        persons.removeAt(index);
      }

      //  persons.remove(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;

    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                if (Responsive.isDesktop(context))
                  const Expanded(child: SideMenu()),
                  */
                Expanded(
                  flex: 5,
                  //    child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: Size.height,
                    child: ModalProgressHUD(
                      inAsyncCall: _isLoading,
                      child: SingleChildScrollView(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Ajouter un Professionnel:',
                                        style: TextStyle(
                                          fontSize: FontSize,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: AppColors.textColor,
                                          decorationColor: AppColors.textColor,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 4),
                                    ExpansionTile(
                                      title: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Text(
                                          'Liste des Professions',
                                          style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      textColor: AppColors.textColor,
                                      iconColor: AppColors
                                          .textColor, // makes the arrow white
                                      collapsedIconColor: AppColors.textColor,
                                      children: [
                                        SizedBox(
                                          height: 600,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: categories.length,
                                            itemBuilder: (context, index) {
                                              final category =
                                                  categories[index];
                                              return ExpansionTile(
                                                title: Text(
                                                  category.name,
                                                  style: TextStyle(
                                                    color: AppColors.textColor,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    AppColors.backgroundColor,
                                                textColor: AppColors.textColor,
                                                iconColor: AppColors
                                                    .textColor, // makes the arrow white
                                                collapsedIconColor:
                                                    AppColors.textColor,

                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16.0,
                                                        ),
                                                    child: Wrap(
                                                      spacing:
                                                          10.0, // horizontal space between checkboxes
                                                      runSpacing:
                                                          4.0, // vertical space if it wraps
                                                      children: category.subCategories.map((
                                                        sub,
                                                      ) {
                                                        final key =
                                                            '${category.name}-$sub';
                                                        return Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Checkbox(
                                                              value:
                                                                  checkedStates[key] ??
                                                                  false,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  checkedStates[key] =
                                                                      value!;
                                                                });
                                                                print(
                                                                  'Selected: $sub (${checkedStates[key]})',
                                                                );
                                                                if (checkedStates[key] !=
                                                                        null &&
                                                                    checkedStates[key] ==
                                                                        true) {
                                                                  names.add(
                                                                    category
                                                                        .name,
                                                                  );
                                                                  selectedProfessions
                                                                      .add(sub);
                                                                } else {
                                                                  names.remove(
                                                                    category
                                                                        .name,
                                                                  );
                                                                  selectedProfessions
                                                                      .remove(
                                                                        sub,
                                                                      );
                                                                }
                                                              },

                                                              activeColor: Colors
                                                                  .green, // the checkmark color
                                                              checkColor:
                                                                  Colors.white,
                                                              side: const BorderSide(
                                                                color: AppColors
                                                                    .textColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              sub,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .textColor,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    CustomTextField(
                                      hasIcon: false,
                                      hintText:
                                          'Veuillez saisir la description de la profession',
                                      isNumber: false,
                                      controller: _descriptionController,
                                      textInputAction: TextInputAction.next,
                                      inputType: TextInputType.multiline,
                                      maxLines: 3,

                                      labelText:
                                          ' Description de la Profession',
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

                                    ...persons.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      Map<PersonModel, dynamic> person =
                                          entry.value;
                                      addControllers(index);
                                      addFormkeys(index);

                                      return Column(
                                        children: [
                                          AddPersonWidget(
                                            firstNameController:
                                                firstNamesControllers[index],
                                            lastNameController:
                                                lastNamesNameControllers[index],
                                            middleNameController:
                                                middleNamesControllers[index],
                                            adresseController:
                                                addressesControllers[index],
                                            emailController:
                                                emailsControllers[index],
                                            telephonController:
                                                phonesControllers[index],
                                            onPickImage: pickAnImage,
                                            onRemoveImage: () {
                                              setState(() {
                                                personImages.removeAt(index);
                                              });
                                            },
                                            pickedImage: pickedImage,
                                            webImage: webImage,
                                            formKey: formKeys[index],
                                            onGenderChanged: (value) {
                                              setState(() {
                                                print(
                                                  'gender sind:  ${genders.length}',
                                                );
                                                genders[index] = value;
                                              });
                                            },
                                            selectedGender: 'm',
                                            onBirthDateChanged: (value) {
                                              setState(() {
                                                addBirthDate(index);
                                                birthdates[index] = value;
                                                print(
                                                  'birthdate sind:  ${birthdates.length}',
                                                );
                                              });
                                            },
                                            adresseType: selectAdresseType,
                                            onAdressTypeChange:
                                                (String? selectedType) {
                                                  setState(() {
                                                    selectAdresseType =
                                                        selectedType;
                                                  });
                                                }, quartierController: quartierControllers[index], commune: selectCommune, onCommuneChange: (String? value) { 
                                                  setState(() {
                                                    selectCommune = value;
                                                  });
                                                 },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.backgroundColor,
                                                  foregroundColor: AppColors
                                                      .textColor, // 👈 text/icon color
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 12,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  alignment: Alignment.center,
                                                ),

                                                onPressed: addIngredient,
                                                child: Text(
                                                  '+ Ajouter un Contact ',
                                                  style: TextStyle(
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    color: AppColors.textColor,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () => {
                                                    print(
                                                      'the index is: $index',
                                                    ),
                                                    removeIngredient(index),
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),

                                    SizedBox(height: 10),

                                    CustomButon(
                                      text: 'Enregistrer',
                                      icon: Icons.upload,
                                      onTap: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        final form = formKey.currentState;
                                        if (personImages.isNotEmpty &&
                                            form != null &&
                                            form.validate() &&
                                            selectedProfessions.isNotEmpty) {
                                          form.save();
                                          final uuid = const Uuid().v4();
                                          try {
                                            bool allValid = true;
                                            for (final key in formKeys) {
                                              if (!(key.currentState
                                                      ?.validate() ??
                                                  false)) {
                                                allValid = false;
                                              }
                                            }
                                            if (personImages.isNotEmpty &&
                                                allValid) {
                                              for (
                                                int i = 0;
                                                i < personImages.length;
                                                i++
                                              ) {
                                                /*
                                                  final  professionnel =
                                                      ProfessionnelModel(
                                                        id: _uuid,
                                                        name: names.first,
                                                        createdAt: DateTime.now(),
                                                        description:
                                                            _descriptionController
                                                                .text,
                                                        professions:
                                                            selectedProfessions,
                                                        persons:
                                                            await getAllPersons(),
                                                      );
                                  
                                                  await professionnelService
                                                      .addModel(professionnel);   
                                                      */

                                                setState(() {
                                                  for (
                                                    int i = 0;
                                                    i <
                                                        firstNamesControllers
                                                            .length;
                                                    i++
                                                  ) {
                                                    firstNamesControllers[i]
                                                        .clear();
                                                    lastNamesNameControllers[i]
                                                        .clear();
                                                    surnamesControllers[i]
                                                        .clear();
                                                    middleNamesControllers[i]
                                                        .clear();
                                                    emailsControllers[i]
                                                        .clear();
                                                    phonesControllers[i]
                                                        .clear();
                                                    gendersControllers[i]
                                                        .clear();
                                                    quartierControllers
                                                        .clear();
                                                    birthdatesControllers[i]
                                                        .clear();
                                                    addressesControllers[i]
                                                        .clear();
                                                    _descriptionController
                                                        .clear();
                                                    checkedStates.clear();
                                                  }
                                                });

                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                showAlertBar(
                                                  context,
                                                  'Nouveau Fournisseur Ajouter avec succes!',
                                                );
                                              }
                                            } else {
                                              showBtmAlert(
                                                context,
                                                "veillez choisir une image pour le professionnel !!!",
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
                                          if (personImages.isEmpty) {
                                            showBtmAlert(
                                              context,
                                              "veillez choisir une image pour le professionnel !!!",
                                            );
                                          }
                                          if (selectedProfessions.isEmpty) {
                                            showBtmAlert(
                                              context,
                                              "veillez choisir une categorie pour le professionnel !!!",
                                            );
                                          }
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
                  ),
                  //  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
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
          print('picked Image: $_pickedImage');
        });
      } else {
        showBtmAlert(context, 'please select an image');
      }
    } else {
      showBtmAlert(context, 'Something went wrong');
    }
  }
*/
  Future<String?> _uploadImageToFirebase(int index) async {
    try {
      final storage = FirebaseStorage.instance;

      // Create a unique file name
      String fileName =
          'professionnels/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = storage.ref().child(fileName);

      UploadTask uploadTask;

      if (kIsWeb) {
        // Upload bytes for web
        UploadTask uploadTask = ref.putData(
          // webImage!, // from your _pickImage()
          webImage!,
          SettableMetadata(contentType: 'image/jpeg'),
        );
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        // Upload file for mobile
        UploadTask uploadTask = ref.putFile(
          personImages[index]!,
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

  void addControllers(int index) {
    if (firstNamesControllers.length <= index) {
      firstNamesControllers.add(TextEditingController());
    }
    if (lastNamesNameControllers.length <= index) {
      lastNamesNameControllers.add(TextEditingController());
    }
    if (surnamesControllers.length <= index) {
      surnamesControllers.add(TextEditingController());
    }
    if (middleNamesControllers.length <= index) {
      middleNamesControllers.add(TextEditingController());
    }
    /*
    if (profileImageUrlsControllers.length <= index) {
      profileImageUrlsControllers.add(TextEditingController());
    }
    */
    if (emailsControllers.length <= index) {
      emailsControllers.add(TextEditingController());
    }
    if (phonesControllers.length <= index) {
      phonesControllers.add(TextEditingController());
    }
    if (gendersControllers.length <= index) {
      gendersControllers.add(TextEditingController());
    }
    if (birthdatesControllers.length <= index) {
      birthdatesControllers.add(TextEditingController());
    }
    if (addressesControllers.length <= index) {
      addressesControllers.add(TextEditingController());
    }
    if (quartierControllers.length <= index) {
      quartierControllers.add(TextEditingController());
    }
  }

  void addFormkeys(int index) {
    if (formKeys.length <= index) {
      formKeys.add(GlobalKey<FormState>());
    }
  }

  void addGender(int index) async {
    if (genders.length <= index) {
      genders.add('');
    }
  }

  void addBirthDate(int index) async {
    if (birthdates.length <= index) {
      birthdates.add(DateTime(1980, 1, 1));
    }
  }

  Future<List<PersonModel>> getAllPersons() async {
    List<PersonModel> persons = [];
    for (int i = 0; i < personImages.length; i++) {
      String? imageUrl = await _uploadImageToFirebase(i);
      persons.add(
        PersonModel(
          id: Uuid().v4(),
          name: names[i],
          createdAt: DateTime.now(),
          firstName: firstNamesControllers[i].text,
          lastName: lastNamesNameControllers[i].text,
          middleName: middleNamesControllers[i].text,
          email: emailsControllers[i].text,
          phone: phonesControllers[i].text,
          profileImageUrl: imageUrl!,
          gender: genders[i]!,
          birthDate: birthdates[i]!,
          addresses: [
            AdressModel(
              address: addressesControllers[i].text,
              id: Uuid().v4(),
              name: selectAdresseType!,
              createdAt: DateTime.now(),
               quartier: quartierControllers[i].text,
                commune: selectCommune,
            ),
          ],
        ),
      );
    }
    return persons;
  }

  Future<void> pickAnImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          //  widget.pickedImage = selected;
          pickedImage = selected;
          personImages.add(selected);
        });
      } else {
        showBtmAlert(context, imageConstatnt.getImageSelectionText());
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          pickedImage = File('a');
          personImages.add(pickedImage);
        });
      } else {
        showBtmAlert(context, imageConstatnt.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, imageConstatnt.getImageSelectionErrorText());
    }
  }
}
