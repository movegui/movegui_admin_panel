// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/screens/auth/login_screen.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/profile_menu_title.dart';
import 'package:movegui_admin_panel/widgets/auth/movegui_profile_header_widget.dart';
import 'package:uuid/uuid.dart';

class MoveguiProfileScreen extends StatefulWidget {
  const MoveguiProfileScreen({super.key, this.currentUser});
  final UserModel? currentUser;

  @override
  State<StatefulWidget> createState() => MoveguiProfileScreenState();
}

class MoveguiProfileScreenState extends State<MoveguiProfileScreen> {
  FirebaseAuth? auth;
  File? pickedImage;
  Uint8List? webImage;
  late String gender;
  late DateTime birthdate;
  late UserModel? currentUser;
  late UserService userService;
  late ImageService imageService;
  late TextEditingController nameController;
  late FocusNode nameFocusNode;
  XFile? _pickedImage;
  late bool isNew;
  late int loginMode = -1;
  late bool isEditing;

  Future<void> onNameUpdate(String? value) async {
    nameController.text = value!;
    if (value.isNotEmpty && currentUser != null) {
      UserModel updatedUser = UserModel(
        updatedAt: DateTime.now(),
        id: currentUser!.id,
        name: nameController.text,
        createdAt: currentUser!.createdAt,
        username: currentUser!.username,
        personModel: currentUser!.personModel,
        isVerified: currentUser!.isVerified,
        role: currentUser!.role,
      );
      await userService.update(updatedUser);
      setState(() {
        currentUser = updatedUser;
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.success_login_message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        isEditing = false;
      });
    } else {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_send_mail_title,
        AppLocalizations.of(context)!.error_send_mail_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.camera,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        await updloadImage(bytes);
        setState(() {
          webImage = bytes;
        });
      },
      galleryFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        await updloadImage(bytes);
        setState(() {
          webImage = bytes;
        });
      },
      removeFCT: () {
        setState(() {
          webImage = null;
          pickedImage = null;
        });
      },
    );
  }

  Future<void> updloadImage(Uint8List? bytes) async {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null && currentUser != null) {
        String? url = await imageService.uploadImage(
          file: null,
          webBytes: bytes,
          collectionName: userService.getCollectionName(),
        );
        if (url != null) {
          UserModel updatedUser = UserModel(
            updatedAt: DateTime.now(),
            id: currentUser!.id,
            name: currentUser!.name,
            createdAt: currentUser!.createdAt,
            username: currentUser!.username,
            isVerified: currentUser!.isVerified,

            personModel: PersonModel(
              id: currentUser!.personModel!.id,
              name: currentUser!.name,
              createdAt: DateTime.now(),
              firstName: currentUser!.name,
              lastName: currentUser!.personModel!.lastName,
              profileImageUrl: url,
              email: currentUser!.personModel!.email,
              phone: currentUser!.personModel!.phone,
              gender: currentUser!.personModel!.gender,
              birthDate: currentUser!.personModel!.birthDate,
              addresses: currentUser!.personModel!.addresses,
            ),
            role: currentUser!.role,
          );
          if (isNew) {
            await userService.addModel(updatedUser);
          } else {
            await userService.update(updatedUser);
            isNew = false;
          }
          setState(() {
            currentUser = updatedUser;
          });
        }
      } else {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_send_mail_title,
          AppLocalizations.of(context)!.error_send_mail_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }
    });
  }

  @override
  void initState() {
    userService = getIt<UserService>();
    imageService = getIt<ImageService>();
    auth = FirebaseAuth.instance;
    currentUser = null;
    nameController = TextEditingController();
    nameFocusNode = FocusNode();
    isNew = false;
    isEditing = false;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initialize();
    });
  }

  Future<void> _initialize() async {
    if (widget.currentUser != null) currentUser = widget.currentUser;
    if (auth?.currentUser != null) {
      if (auth?.currentUser?.email != null) {
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            currentUser = await userService.getByEmail(
              auth?.currentUser?.email ?? '',
            );
            isNew = false;
            setState(() {});
          });
        });
      }
      if (currentUser == null) {
        isNew = true;
        setState(() {
          currentUser = UserModel(
            updatedAt: DateTime.now(),
            id: auth?.currentUser?.uid ?? '',
            name: auth?.currentUser?.displayName ?? '',
            createdAt: DateTime.now(),
            username: auth?.currentUser?.email,
            isVerified: false,
            personModel: PersonModel(
              id: Uuid().v4(),
              name: auth?.currentUser?.displayName ?? '',
              createdAt: DateTime.now(),
              firstName: '',
              lastName: auth?.currentUser?.displayName ?? '',
              profileImageUrl: null,
              email: auth?.currentUser?.email,

              phone: null,
              gender: '',
              birthDate: null,
              addresses: [],
            ),
            role: UserRole.Guest.name,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //     chekLoginMode();
          return Scaffold(
            backgroundColor: AppColors.textColor,
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(
                  WidgetConstants.sepWidgetHeight * 2,
                ),
                children: [
                  headerProfile(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildFirstSection(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildSecondSection(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildThirdSection(),
                ],
              ),
            ),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }

  Widget _buildFirstSection() {
    return _sectionCard([
      currentUser != null
          ? ProfileMenuTitle(
              icon: Icons.logout,
              title: AppLocalizations.of(context)!.profile_menu_logout,
              onTap: () async {
                await userService.signOut();
                setState(() {
                  currentUser == null;
                });
              },
              enabled: true,
              routeName: RouteConstants.LOGOUT_ROUTE,
            )
          : ProfileMenuTitle(
              icon: Icons.login,
              title: AppLocalizations.of(context)!.profile_menu_login,
              onTap: () =>
                 context.go(RouteConstants.LOGIN_ROUTE),
              enabled: true,
              routeName: RouteConstants.LOGIN_ROUTE,
            ),

      ProfileMenuTitle(
        icon: Icons.person_add,
        title: AppLocalizations.of(context)!.profile_menu_invite_people,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
      ProfileMenuTitle(
        icon: Icons.list,
        title: AppLocalizations.of(context)!.profile_menu_orders,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
      ProfileMenuTitle(
        icon: Icons.campaign,
        title: AppLocalizations.of(context)!.profile_menu_message,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
      ProfileMenuTitle(
        icon: Icons.star_border,
        title: AppLocalizations.of(context)!.profile_menu_important,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
      ProfileMenuTitle(
        icon: Icons.devices,
        title: AppLocalizations.of(context)!.profile_menu_devices,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
    ]);
  }

  Widget _buildSecondSection() {
    return _sectionCard([
      ProfileMenuTitle(
        icon: Icons.key,
        title: AppLocalizations.of(context)!.profile_menu_account,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
      ProfileMenuTitle(
        icon: Icons.lock_outline,
        title: AppLocalizations.of(context)!.profile_menu_confidentiality,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
      ProfileMenuTitle(
        icon: Icons.chat_bubble_outline,
        title: AppLocalizations.of(context)!.profile_menu_discussions,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
      ProfileMenuTitle(
        icon: Icons.notifications_none,
        title: AppLocalizations.of(context)!.notification_title,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
    ]);
  }

  Widget _buildThirdSection() {
    return _sectionCard([
      ProfileMenuTitle(
        icon: Icons.delete,
        title: AppLocalizations.of(context)!.profile_menu_delete_account,
        onTap: () => notImplemented(),
        enabled: false, routeName: '',
      ),
    ]);
  }

  Widget _sectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(
          children.length,
          (index) => Column(
            children: [
              children[index],
              if (index != children.length - 1)
                const Divider(height: 1, indent: 56),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerProfile() {
    return MoveguiProfileHeaderWidget(
      onNameUpdate: (value) async {
        onNameUpdate(value);
      },
      onPickImage: () async {
        localImagePicker();
      },
      currentUser: currentUser,
      nameController: nameController,
      nameFocusNode: nameFocusNode,
      pickedImage: pickedImage,
      webImage: webImage,
      isEditing: isEditing,
      onChangeEditing: (value) async {
        setState(() {
          isEditing = !value;
        });
      },
    );
  }

  Future<dynamic> notImplemented() {
    return MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }

  void navigateToRoute(String routeName){
    context.go(routeName);
  }
}
