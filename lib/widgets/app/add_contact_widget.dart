import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/add_person_widget.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';
import 'package:uuid/uuid.dart';

class AddContactWidget extends StatefulWidget {
  const AddContactWidget({super.key, required this.onContactsChanged});
  final Function(List<PersonModel>) onContactsChanged;

  @override
  AddContactWidgetState createState() => AddContactWidgetState();
}

class AddContactWidgetState extends State<AddContactWidget> {
  final List<GlobalKey<FormState>> formKeys = [];
  final List<TextEditingController> firstNames = [];
  final List<TextEditingController> lastNames = [];
  final List<TextEditingController> middleNames = [];
  final List<TextEditingController> addresses = [];
  final List<TextEditingController> emails = [];
  final List<TextEditingController> phones = [];
   final List<TextEditingController> quartiers = [];
  final List<String> genders = [];
  final List<DateTime?> birthdates = [];
  final List<File?> images = [];
  late Uint8List? webImage;
  late File? pickedImage;
  late ImageConstatnt imageConstatnt;
  final List<String?> addressSlectedTypes = [];
   final List<String?> selectedCommunes = [];

  @override
  void initState() {
    super.initState();
    webImage = null;
    pickedImage = null;
    imageConstatnt = ImageConstatnt();

    _addPerson();
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < firstNames.length; i++) {
      firstNames[i].dispose();
      lastNames[i].dispose();
      middleNames[i].dispose();
      addresses[i].dispose();
      emails[i].dispose();
      phones[i].dispose();
      quartiers[i].dispose();
    }
  }

  void clear() {
    for (int i = 0; i < formKeys.length; i++) {
      remove(i);
    }
    firstNames.clear();
    lastNames.clear();
    middleNames.clear();
    addresses.clear();
    emails.clear();
    phones.clear();
    genders.clear();
    images.clear();
    birthdates.clear();
    addressSlectedTypes.clear();
    quartiers.clear();
    selectedCommunes.clear();
    setState(() {
      webImage = null;
      pickedImage = null;
    });
    _addPerson();
  }

  Future<void> updateParent() async {
    final contacts = await getContacts();
    widget.onContactsChanged(contacts);
  }

  Future<void> _addPerson() async {
    setState(() {
      formKeys.add(GlobalKey<FormState>());
      firstNames.add(TextEditingController());
      lastNames.add(TextEditingController());
      middleNames.add(TextEditingController());
      addresses.add(TextEditingController());
      emails.add(TextEditingController());
      phones.add(TextEditingController());
      quartiers.add(TextEditingController());
      genders.add("m");
      birthdates.add(null);
      images.add(null);
      addressSlectedTypes.add('h');
      selectedCommunes.add('di');
    });
    updateParent();
  }

  void _removePerson(int index) {
    if (formKeys.length == 1) return;
    remove(index);
  }

  void remove(int index) {
    setState(() {
      firstNames[index].dispose();
      lastNames[index].dispose();
      middleNames[index].dispose();
      addresses[index].dispose();
      emails[index].dispose();
      phones[index].dispose();

      formKeys.removeAt(index);
      firstNames.removeAt(index);
      lastNames.removeAt(index);
      middleNames.removeAt(index);
      addresses.removeAt(index);
      emails.removeAt(index);
      phones.removeAt(index);
      genders.removeAt(index);
      birthdates.removeAt(index);
      images.removeAt(index);
      addressSlectedTypes.removeAt(index);
      selectedCommunes.removeAt(index);
      quartiers.removeAt(index);
    });
  }

  // ✅ Expose contact data as a list of maps or a model
  Future<List<PersonModel>> getContacts() async {
    List<PersonModel> contacts = [];

    for (int i = 0; i < formKeys.length; i++) {
      contacts.add(
        PersonModel(
          id: const Uuid().v4(),
          firstName: firstNames[i].text,
          lastName: lastNames[i].text,
          name: "${firstNames[i].text} ${lastNames[i].text}",
          createdAt: DateTime.now(),
          middleName: middleNames[i].text.isEmpty ? null : middleNames[i].text,
          profileImageUrl: await _uploadImageToFirebase(
            Uint8List(8),
            images[i],
          ),
          birthDate: birthdates[i],
          addresses: [ AdressModel(address: addresses[i].text, id: Uuid().v4(), name: addressSlectedTypes[i]!, createdAt: DateTime.now(), quartier: quartiers[i].text, commune: selectedCommunes[i]) ],
          email: emails[i].text,
          phone: phones[i].text,
          gender: genders[i],
          //  image: images[i],
        ),
      );
    }
    return contacts;
  }

  Future<String?> _uploadImageToFirebase(
    Uint8List webImage,
    File? pickedImage,
  ) async {
    try {
      final storage = FirebaseStorage.instance;

      // Create a unique file name
      String fileName = 'persons/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = storage.ref().child(fileName);

      UploadTask uploadTask;

      if (kIsWeb) {
        // Upload bytes for web
        UploadTask uploadTask = ref.putData(
          webImage, // from your _pickImage()
          SettableMetadata(contentType: 'image/jpeg'),
        );
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        // Upload file for mobile
        UploadTask uploadTask = ref.putFile(
          pickedImage!,
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

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: firstNames.length,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
            width: Responsive.isDesktop(context)
                ? Size.width * 0.4
                : double.infinity,
            //   height: Size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.backgroundColor, //Colors.grey.withOpacity(0.3),
            ),
            child: Column(
              children: [
                AddPersonWidget(
                  formKey: formKeys[index],
                  firstNameController: firstNames[index],
                  lastNameController: lastNames[index],
                  middleNameController: middleNames[index],
                  adresseController: addresses[index],
                  emailController: emails[index],
                  telephonController: phones[index],
                  selectedGender: genders[index],
                  onGenderChanged: (value) {
                    setState(() => genders[index] = value!);
                  },
                  onBirthDateChanged: (value) {
                    setState(() => birthdates[index] = value!);
                  },
                  onPickImage: pickAnImage,
                  onRemoveImage: () {
                    setState(() {
                      pickedImage = null;
                      webImage = null;
                      images.removeAt(index);
                    });
                  },
                  pickedImage: pickedImage,
                  webImage: webImage, 
                  adresseType: addressSlectedTypes[index], 
                  onAdressTypeChange: (String? selectedValue) { 
                    setState(() {
                      addressSlectedTypes[index] = selectedValue!;
                    });
                   }, quartierController: quartiers[index], commune: selectedCommunes[index], onCommuneChange: (String? value) { 
                    setState(() {
                      selectedCommunes[index] = value;
                    });
                    }, longitudeController: TextEditingController(), latitudeController: TextEditingController(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        onPressed: (item) async {
                          _addPerson();
                        },
                        buttonItem: ButtonItem(
                          AppLocalizations.of(context)!.btn_add_contact,
                          onPress: () {},
                          tooltipText: AppLocalizations.of(
                            context,
                          )!.tooltip_btn_add_contact,
                          enabled: true,
                          routeName: '',
                        ),
                        icon: Icons.add,
                        backgroundColor: AppColors.darkPrimary,
                      ),
                    ),

                    Expanded(
                      child: IconButton(
                        onPressed: () => _removePerson(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                SeparatorWidget(height: WidgetConstants.sepWidget),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: WidgetConstants.sepWidget);
      },
    );
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
          images.add(selected);
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
          images.add(pickedImage);
        });
      } else {
        showBtmAlert(context, imageConstatnt.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, imageConstatnt.getImageSelectionErrorText());
    }
  }
}
