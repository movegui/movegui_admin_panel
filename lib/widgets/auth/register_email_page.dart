import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/auth_provider.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/add_person_widget.dart';
import 'package:movegui_admin_panel/widgets/app/auth/validation_button.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/auth/repeat_password_widget.dart';
import 'package:uuid/uuid.dart';

class RegisterEmailPage extends ConsumerStatefulWidget {
  final UserRole role;
  const RegisterEmailPage({super.key, required this.role});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      RegisterEmailPageState();
}

class RegisterEmailPageState extends ConsumerState<RegisterEmailPage> {
  bool obscureText = true;
  late final TextEditingController _emailController,
      _passwordController,
      _repeatPasswordController,
      firstNameController,
      lastNameController,
      middleNameController,
      adresseController,
      telephonController,
      quartierController;

  String? selectAdresseType;
  String? selectCommune;

  late final FocusNode _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  final _personFormkey = GlobalKey<FormState>();
  bool isloading = false;
  FirebaseAuth? auth;
  late UserService userService;
  UserModel? currentUser;
  String? selectedGender;
  late Uint8List? webImage;
  late File? pickedImage;
  late ImageConstatnt imageConstatnt;
  DateTime? birthDate;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    middleNameController = TextEditingController();
    adresseController = TextEditingController();
    telephonController = TextEditingController();
    quartierController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    userService = getIt<UserService>();
    webImage = null;
    pickedImage = null;
    imageConstatnt = ImageConstatnt();
    selectedGender = 'm';
    birthDate = null;
    selectAdresseType = 'h';
    selectCommune = 'di';
    try {
      auth = FirebaseAuth.instance;
    } catch (e) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: AppLocalizations.of(
          context,
        )!.error_firebase_initialisation.toString(),
        fct: () {},
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      _repeatPasswordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _registerFCT(ButtonItem item) async {
    final isValid = _formkey.currentState!.validate() && birthDate != null;
    final authProvider = ref.read(authStateProvider);
    UserModel? adminUser;

    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });

        final user = authProvider.value;

        if (user != null) {
          try {
            currentUser = await userService.getCurrentUserByMail(
              user.email!,
              ref,
            );
            final isAuthorize =
                await userService.isSuperUser(context, ref) ||
                await userService.isAdmin(context, ref);
            if (isAuthorize) {
              final adminUser = await userService.createUser(
                _emailController.text.trim(),
                _passwordController.text.trim(),
                widget.role.name,
                firstNameController.text.trim(),
                lastNameController.text.trim(),
                [
                  AdressModel(
                    address: adresseController.text.trim(),
                    id: Uuid().v4(),
                    name: selectAdresseType!,
                    createdAt: DateTime.now(),
                    quartier: quartierController.text,
                    commune: selectCommune,
                  ),
                ],
                telephonController.text.trim(),
                selectedGender!,
                birthDate!,
              );
              if (adminUser != null) {
                await userService.addModel(adminUser);
                setState(() {
                  isloading = false;
                });
                if (!mounted) return;
                context.go(item.routeName!);
                Fluttertoast.showToast(
                  msg: AppLocalizations.of(
                    context,
                  )!.success_registration_new_user,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                MessageWidget.errorMessage(
                  context,
                  AppLocalizations.of(context)!.error_register_with_phone_title,
                  AppLocalizations.of(
                    context,
                  )!.error_register_with_email_message,
                  Icon(Icons.error, color: AppColors.error),
                  FlushbarPosition.TOP,
                );
              }
            }
          } on FirebaseException catch (e) {
            print(e);
            MessageWidget.errorMessage(
              context,
              AppLocalizations.of(context)!.error_register_with_phone_title,
              AppLocalizations.of(context)!.error_register_with_email_message,
              Icon(Icons.error, color: AppColors.error),
              FlushbarPosition.TOP,
            );
          }
        } else {
          context.go(RouteConstants.LOGIN_ROUTE);
        }
      } catch (error) {
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: () {},
        );
      } finally {
        isloading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.input_hint_adress_email,
                prefixIcon: const Icon(
                  Icons.mail,
                  color: AppColors.backgroundColor,
                ),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              validator: (value) {
                return MyValidators.emailValidator(value);
              },
            ),

            const SizedBox(height: 8.0),
            RepeatPasswordWidget(
              passwordController: _passwordController,
              repeatPasswordController: _repeatPasswordController,
              passwordFocusNode: _passwordFocusNode,
              repeatPasswordFocusNode: _repeatPasswordFocusNode,
            ),

            AddPersonWidget(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              middleNameController: middleNameController,
              adresseController: adresseController,
              telephonController: telephonController,
              emailController: _emailController,
              formKey: _personFormkey,
              onBirthDateChanged: (value) {
                setState(() {
                  birthDate = value;
                });
              },
              onGenderChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
              selectedGender: selectedGender,
              webImage: webImage,
              pickedImage: pickedImage,
              onPickImage: onPickImage,
              onRemoveImage: () {
                setState(() {
                  pickedImage = null;
                  webImage = null;
                });
              },
              showBild: false,
              adresseType: selectAdresseType,
              onAdressTypeChange: (String? addressType) {
                setState(() {
                  selectAdresseType = addressType;
                });
              },
              quartierController: quartierController,
              commune: selectCommune,
              onCommuneChange: (String? value) {
                setState(() {
                  selectCommune = value;
                });
              },
            ),

            Responsive.isDesktop(context)
                ? SeparatorWidget(height: 20)
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(WidgetConstants.sepWidget),
              child: ValidationButton(
                fn: _registerFCT,
                buttonItem: ButtonItem(
                  AppLocalizations.of(context)!.btn_register_label,
                  tooltipText: AppLocalizations.of(
                    context,
                  )!.tooltip_registration,
                  enabled: true,
                  routeName: RouteConstants.HOME_ROUTE,
                  onPress: () {},
                ),
              ),
            ),
            if (isloading)
              Container(
                color: AppColors.backgroundColor,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.selectionColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> onPickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          //  widget.pickedImage = selected;
          pickedImage = selected;
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
        });
      } else {
        showBtmAlert(context, imageConstatnt.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, imageConstatnt.getImageSelectionErrorText());
    }
  }
}
