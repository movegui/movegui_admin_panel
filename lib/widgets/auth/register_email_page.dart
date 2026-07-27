import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/auth_provider.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/address_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';
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
  late PersonFormController formController;
  final GlobalKey<FormState> addAddressKey = GlobalKey();
  final GlobalKey<FormState> addPersonKey = GlobalKey();

  late final TextEditingController _passwordController,
      _repeatPasswordController;

  late final FocusNode _passwordFocusNode, _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  FirebaseAuth? auth;
  late UserService userService;
  late AddressService addressService;
  UserModel? currentUser;
  late ImageConstatnt imageConstatnt;
  /*
  String? selectedGender;
  late Uint8List? webImage;
  late File? pickedImage;
  DateTime? birthDate;
  */

  @override
  void initState() {
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();

    userService = getIt<UserService>();
    addressService = getIt<AddressService>();
    imageConstatnt = ImageConstatnt();
    /*
    webImage = null;
    pickedImage = null;

    selectedGender = 'm';
    birthDate = null;
    */
    formController = PersonFormController();

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
      _passwordController.dispose();
      _repeatPasswordController.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
      formController.dispose();
    }
    super.dispose();
  }

  Future<void> _registerFCT(ButtonItem item) async {
    final isValid =
        _formkey.currentState!.validate() && formController.birthdate != null;
    final authProvider = ref.read(authStateProvider);

    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
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
              final addressModel = AdressModel(
                address: formController.addressesForms[0].address.text.trim(),
                id: Uuid().v4(),
                name: formController.addressesForms[0].selectedType,
                createdAt: DateTime.now(),
                district: formController.addressesForms[0].district.text.trim(),
                minucipality:
                    formController.addressesForms[0].selectedMunicipality,
              );
              GeoCordinatesModel? geoCoord = await addressService
                  .getCoordinates(addressModel.getMapAddress());
              // ignore: prefer_conditional_assignment
              if (geoCoord == null) {
                geoCoord = GeoCordinatesModel(
                  longitude: double.parse(
                    formController.addressesForms[0].longitude.text.trim(),
                  ),
                  latitude: double.parse(
                    formController.addressesForms[0].latitude.text.trim(),
                  ),
                );
              }
              final adminUser = await userService.createUser(
                formController.email.text.trim(),
                _passwordController.text.trim(),
                widget.role.name,
                formController.firstName.text.trim(),
                formController.lastName.text.trim(),
                [
                  AdressModel(
                    address: formController.addressesForms[0].address.text
                        .trim(),
                    id: Uuid().v4(),
                    name: formController.addressesForms[0].selectedType,
                    createdAt: DateTime.now(),
                    district: formController.addressesForms[0].district.text
                        .trim(),
                    minucipality:
                        formController.addressesForms[0].selectedMunicipality,
                    geoCordinates: geoCoord,
                    zoneId:
                        '${formController.addressesForms[0].selectedMunicipality} _ ${formController.addressesForms[0].district.text.trim()} _ ${formController.addressesForms[0].address.text.trim()}',
                  ),
                ],
                formController.phone.text.trim(),
                formController.gender!,
                formController.birthdate!,
              );
              if (adminUser != null) {
                await userService.addModel(adminUser);
                setState(() {
                  isLoading = false;
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
                FirebaseAuth.instance.currentUser?.delete();
                MessageWidget.errorMessage(
                  context,
                  AppLocalizations.of(context)!.error_register_title,
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
              AppLocalizations.of(context)!.error_register_title,
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
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: formController.email,
            focusNode: formController.emailFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.input_hint_adress_email,
              prefixIcon: const Icon(
                Icons.mail,
              
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
            //  formKey: _personFormkey,
            onBirthDateChanged: (value) {
              setState(() {
                formController.birthdate = value;
              });
            },
            onGenderChanged: (value) {
              setState(() {
                formController.gender = value;
              });
            },

            onPickImage: onPickImage,
            onRemoveImage: () {
              setState(() {
                formController.pickedImage = null;
                formController.webImage = null;
              });
            },
            showBild: false,
            onAdressTypeChange: (String? addressType) {
              setState(() {
                formController.addressesForms[0].selectedType = addressType!;
              });
            },

            onCommuneChange: (String? value) {
              setState(() {
                formController.addressesForms[0].selectedMunicipality = value!;
              });
            },

          
            personForm: formController,
        //    personKey: addPersonKey,
       //     addAddressKey: addAddressKey,
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
                tooltipText: AppLocalizations.of(context)!.tooltip_registration,
                enabled: true,
                routeName: RouteConstants.HOME_ROUTE,
                onPress: () {},
              ),
            ),
          ),
          if (isLoading)
            CircularProgressIndicator(
              strokeWidth: 3,
             
            ),
        ],
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
          formController.pickedImage = selected;
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
          formController.webImage = f;
          formController.pickedImage = File('a');
        });
      } else {
        showBtmAlert(context, imageConstatnt.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, imageConstatnt.getImageSelectionErrorText());
    }
  }
}
