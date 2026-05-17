import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/util/pressing_submit_handler.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/auth/validation_button.dart';
import 'package:movegui_admin_panel/widgets/app/opens_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/store_widget.dart';

class AddPressingWidget extends StatefulWidget {
  const AddPressingWidget({super.key});
  final String collectionName = 'pressings';

  @override
  State<StatefulWidget> createState() => PressingAddWidgetPageState();
}

class PressingAddWidgetPageState extends State<AddPressingWidget> {
  final formController = StoreFormController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<AddContactWidgetState> addContactKey = GlobalKey();
  final GlobalKey<WeeklyHoursScreenState> addOpenHoursKey = GlobalKey();
  bool isLoading = false;
  late PressingService pressingService;
  late RestaurantTypeService restaurantTypeService;

  @override
  void initState() {
    pressingService = getIt<PressingService>();
    restaurantTypeService = getIt<RestaurantTypeService>();
    super.initState();
  }

  late final submitHandler = PressingSubmitHandler(
    service: pressingService,
    imageService: ImageService(),
    collectionName: widget.collectionName,
  );

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      formController.contacts = await addContactKey.currentState!.getContacts();
      //  formController.weeklyHours = await addOpenHoursKey.currentState!.getOpenHours();
      if (formController.weeklyHours.isNotEmpty &&
          formController.contacts.isNotEmpty &&
          formController.selectedType != null) {
        await submitHandler.submit(form: formController);
        showAlertBar(
          context,
          AppLocalizations.of(context)!.store_add_success_message(
            AppLocalizations.of(context)!.category_pressing_name,
          ),
        );
        addContactKey.currentState!.clear();
        addOpenHoursKey.currentState!.resetOpenHours();
        formController.clear();
        /*
        formController.dispose();
        addContactKey.currentState!.dispose();
        */
      }
    } catch (e) {
      showBtmAlert(context, e.toString());
    }

    setState(() => isLoading = false);
  }

  Future<void> pickAnImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          formController.pickedImage = selected;
        });
      } else {
        showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
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
        showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
      }
    } else {
      showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
    }
  }

  @override
  Widget build(BuildContext context) {
    //  return Responsive.isDesktop(context) ? buildDesktop(context) : buildMobile(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: PressingConstants(),
                    nameController: formController.name,
                    adresseController: formController.adresse,
                    telephonController: formController.telephon,
                    emailController: formController.email,
                    descriptionController: formController.description,
                    nameFocus: formController.nameFocus,
                    descriptionFocus: formController.descriptionFocus,
                    adresseFocus: formController.adresseFocus,
                    emailFocus: formController.emailFocus,
                    telephonFocus: formController.telephonFocus,
                    webImage: formController.webImage,
                    pickedImage: formController.pickedImage,
                    onPickImage: pickAnImage,
                    onRemoveImage: () {
                      setState(() {
                        formController.pickedImage = null;
                        formController.webImage = Uint8List(8);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AddContactWidget(
                    key: addContactKey,
                    onContactsChanged: (contacts) {
                      setState(() {
                        formController.contacts = contacts;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: OpenHoursWidget(
                    key: addOpenHoursKey,
                    onHoursChanged: (hours) {
                      setState(() {
                        formController.weeklyHours =
                            hours; // Or whatever handling you want
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ValidationButton(
                    fn: (item) async {
                      _onSubmit();
                    },
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.btn_register_label,
                      onPress: () {},
                      tooltipText: AppLocalizations.of(
                        context,
                      )!.tooltip_registration,
                      enabled: true,
                      routeName: '',
                    ),
                    icon: Icons.save,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: PressingConstants(),
                    nameController: formController.name,
                    adresseController: formController.adresse,
                    telephonController: formController.telephon,
                    emailController: formController.email,
                    descriptionController: formController.description,
                    nameFocus: formController.nameFocus,
                    descriptionFocus: formController.descriptionFocus,
                    adresseFocus: formController.adresseFocus,
                    emailFocus: formController.emailFocus,
                    telephonFocus: formController.telephonFocus,
                    webImage: formController.webImage,
                    pickedImage: formController.pickedImage,
                    onPickImage: pickAnImage,
                    onRemoveImage: () {
                      setState(() {
                        formController.pickedImage = null;
                        formController.webImage = Uint8List(8);
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AddContactWidget(
                    key: addContactKey,
                    onContactsChanged: (contacts) {
                      setState(() {
                        formController.contacts = contacts;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: OpenHoursWidget(
                    key: addOpenHoursKey,
                    onHoursChanged: (hours) {
                      setState(() {
                        print(
                          'hours is: ${hours.map((e) => (e.closeTime != null && e.openTime != null) ? e.toJson() : {}).toList()}',
                        );
                        formController.weeklyHours =
                            hours; // Or whatever handling you want
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButon(
                    text: "Enregistrer",
                    icon: Icons.save,
                    onTap: _onSubmit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMobile(BuildContext context) {
    return Scaffold(body: Column(children: [Text('Encours')]));
  }
}
