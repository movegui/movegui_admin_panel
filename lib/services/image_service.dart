import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {

     Future<String?> uploadImage({
    required File? file,
    required Uint8List? webBytes,
    required String collectionName,
  }) async {
    final storage = FirebaseStorage.instance;
    final fileName = '$collectionName/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = storage.ref().child(fileName);

    UploadTask task;

    if (kIsWeb && webBytes != null) {
      task = ref.putData(
        webBytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );
    } else if (file != null) {
      task = ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );
    } else {
      return null;
    }

    return await (await task).ref.getDownloadURL();
  }


    static Future<Map<String?, dynamic>?>pickAnImage() async {
   
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if(image == null) {
        return null;
      } else if(kIsWeb){
        final bytes = await image.readAsBytes();
        return {
          "webImage": bytes,
          "file": File('a')
        };
      }else {
              return {
        "webImage": null,
        "file": File(image.path),
      };
      }

  }

  


}