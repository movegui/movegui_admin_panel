import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/widgets/auth/movegui_profile_default_image.dart';
import 'package:movegui_admin_panel/widgets/auth/movegui_profile_header_update_name.dart';
import 'package:movegui_admin_panel/widgets/subtitle_text.dart';

class MoveguiProfileHeaderWidget extends StatefulWidget {
  final UserModel? currentUser;
  final File? pickedImage;
  final Uint8List? webImage;
  final Future<void> Function(String?) onNameUpdate;
  final Future<void> Function() onPickImage;
  final TextEditingController nameController;
  final FocusNode nameFocusNode;
  final bool isEditing;
  final Future<void> Function(bool) onChangeEditing;

  const MoveguiProfileHeaderWidget({
    super.key,
    required this.currentUser,
    required this.pickedImage,
    required this.webImage,
    required this.onNameUpdate,
    required this.onPickImage,
    required this.nameController,
    required this.nameFocusNode,
    required this.isEditing,
    required this.onChangeEditing,
  });
  @override
  State<StatefulWidget> createState() => MoveguiProfileHeaderWidgetState();
}

class MoveguiProfileHeaderWidgetState
    extends State<MoveguiProfileHeaderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHeader();
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.currentUser?.personModel?.profileImageUrl == null)
          MoveguiProfileDefaultImage(
            onPickImage: widget.onPickImage,
            pickedImage: widget.pickedImage,
            webImage: widget.webImage,
          )
        else if (!widget.isEditing)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              widget.currentUser?.personModel?.profileImageUrl ?? '',
            ),
          )
        else
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  widget.currentUser?.personModel?.profileImageUrl ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: widget.onPickImage,
                  child: const CircleAvatar(
                    radius: 16,
                  
                    child: Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

        if ((widget.currentUser?.name ?? '').trim().isEmpty)
          MoveguiProfileHeaderUpdateName(
            nameController: widget.nameController,
            nameFocusNode: widget.nameFocusNode,
            onNameUpdate: widget.onNameUpdate, // ✅ fix this
          )
        else if (!widget.isEditing)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubtitleTextWidget(
                label: widget.currentUser!.name,
                fontSize: WidgetConstants.sepWidgetHeight * 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.nameController.text = widget.currentUser!.name;
                      widget.onChangeEditing(widget.isEditing);
                    });
                  },
                  child: const CircleAvatar(
                    radius: 16,
                  
                    child: Icon(
                      IconlyLight.edit,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          MoveguiProfileHeaderUpdateName(
            nameController: widget.nameController,
            nameFocusNode: widget.nameFocusNode,
            onNameUpdate: widget.onNameUpdate, // ✅ fix this
          ),
      ],
    );
  }
}
