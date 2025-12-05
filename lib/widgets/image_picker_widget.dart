import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImagePickerWidget extends StatelessWidget{

    final File? pickedImage;
  final Uint8List? webImage;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const ImagePickerWidget({
    super.key,
    required this.pickedImage,
    required this.webImage,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pickedImage == null && (webImage == null || webImage!.isEmpty)
            ? Icon(Icons.image, size: 120)
            : kIsWeb
                ? Image.memory(webImage!, height: 120)
                : Image.file(pickedImage!, height: 120),

        ElevatedButton.icon(
          onPressed: onPick,
          icon: Icon(Icons.upload),
          label: Text("Pick Image"),
        ),
        if (pickedImage != null || (webImage != null && webImage!.isNotEmpty))
          TextButton(onPressed: onRemove, child: Text("Remove")),
      ],
    );
  }
}