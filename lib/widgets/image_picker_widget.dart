import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final Uint8List? webImage;
  final File? pickedImage;
  final double? width;
  final double? height;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final Color bgColor;
  // final String chooseText;

  const ImagePickerWidget({
    super.key,
    required this.webImage,
    required this.pickedImage,
    required this.onPickImage,
    required this.onRemoveImage,
    this.width = 250,
    this.height = 300,
    this.bgColor = const Color.fromARGB(90, 158, 158, 158),
    //   this.chooseText = "Choose an image",
  });

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: pickedImage != null || webImage != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: kIsWeb
                      ? Image.memory(
                          webImage!,
                          width: width! - 10,
                          height: height! - 80,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          pickedImage!,
                          width: width! - 10,
                          height: height! - 80,
                          fit: BoxFit.fill,
                        ),
                ),
                TextButton(
                  onPressed: onRemoveImage,
                  child: const Text(
                    'supprimer',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: onPickImage,
                  child: const Text(
                    'Changer l\'image',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onPickImage,
                  icon: const Icon(Icons.image_outlined),
                ),
                Text(
                  'Choisir une image',
                  style: TextStyle(
                    fontSize: FontSize,
                 
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
