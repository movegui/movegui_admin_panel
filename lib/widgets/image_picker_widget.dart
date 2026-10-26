import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? imageUrl;
  final Uint8List? webImage;
  final File? pickedImage;
  final double? width;
  final double? height;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  const ImagePickerWidget({
    super.key,
    required this.imageUrl,
    this.webImage,
    this.pickedImage,
    this.width,
    this.height,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage =
        webImage != null || pickedImage != null || imageUrl != null;
    final ImageProvider<Object>? imageProvider = webImage != null
        ? MemoryImage(webImage!)
        : pickedImage != null
        ? FileImage(pickedImage!)
        : imageUrl != null
        ? NetworkImage(imageUrl!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: imageProvider == null
                ? _buildPlaceholder(theme)
                : Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholder(theme),
                  ),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: onPickImage,
          icon: const Icon(Icons.image_outlined),
          label: Text(
            hasImage
                ? AppLocalizations.of(context)!.image_change_image_text
                : AppLocalizations.of(context)!.image_change_image_text,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'JPG ou PNG, jusqu’à 5 Mo',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 42,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 10),
        Text(
          'Ajouter une image',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}




/*

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

*/

