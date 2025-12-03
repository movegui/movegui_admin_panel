
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/services/professionnel_service.dart';
import 'package:movegui_admin_panel/widgets/add_person_widget.dart';
import 'package:uuid/uuid.dart';

class AddContactWidget extends StatefulWidget {
  const AddContactWidget({super.key});

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
  final List<String> genders = [];
  final List<DateTime?> birthdates = [];
  final List<File?> images = [];

  @override
  void initState() {
    super.initState();
    _addPerson();
  }

  void _addPerson() {
    setState(() {
      formKeys.add(GlobalKey<FormState>());
      firstNames.add(TextEditingController());
      lastNames.add(TextEditingController());
      middleNames.add(TextEditingController());
      addresses.add(TextEditingController());
      emails.add(TextEditingController());
      phones.add(TextEditingController());
      genders.add("m");
      birthdates.add(null);
      images.add(null);
    });
  }

  void _removePerson(int index) {
    if (formKeys.length == 1) return;
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
    });
  }

  // ✅ Expose contact data as a list of maps or a model
 Future<List<PersonModel>> getContacts() async {
  List<PersonModel> contacts = [];

  for (int i = 0; i < firstNames.length; i++) {
    contacts.add(PersonModel(
      id: const Uuid().v4(),
      firstName: firstNames[i].text,
      lastName: lastNames[i].text,
      name: "${firstNames[i].text} ${lastNames[i].text}",
      createdAt: DateTime.now(),
      middleName: middleNames[i].text.isEmpty ? null : middleNames[i].text,
      profileImageUrl: await _uploadImageToFirebase(Uint8List(8), images[i]),
      birthDate: birthdates[i],
      address: addresses[i].text,
      email: emails[i].text,
      phone: phones[i].text,
      gender: genders[i],
    //  image: images[i],
    ));
  }
  return contacts;
 }

   Future<String?> _uploadImageToFirebase(Uint8List webImage ,File? _pickedImage ) async {
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: firstNames.length,
      itemBuilder: (context, index) {
        return Column(
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
              onImagePicked: (file) {
                setState(() => images[index] = file);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _addPerson,
                  child: const Text("+ Ajouter un Contact"),
                ),
                IconButton(
                  onPressed: () => _removePerson(index),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

