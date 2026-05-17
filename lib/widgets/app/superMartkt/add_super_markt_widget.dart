import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/store_categories_service.dart';
import 'package:movegui_admin_panel/services/super_markts_service.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/util/super_markt_submit_handler.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/opens_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_drop_down.dart';
import 'package:movegui_admin_panel/widgets/store_widget.dart';

class SuperMarktAddWidgetPage extends StatefulWidget {
  const SuperMarktAddWidgetPage({super.key});
  final String collectionName = 'supermarkts';

  @override
  State<StatefulWidget> createState() => SuperMarktAddWidgetPageState();
}

class SuperMarktAddWidgetPageState extends State<SuperMarktAddWidgetPage> {
  final formController = StoreFormController();
  final formKey = GlobalKey<FormState>();
      final GlobalKey<AddContactWidgetState> addContactKey = GlobalKey();
  final GlobalKey<WeeklyHoursScreenState> addOpenHoursKey = GlobalKey();
  bool isLoading = false;
  late SuperMarktsService superMarktsService;
  late RestaurantTypeService restaurantTypeService;
  late SuperMarktConstants superMarktConstants;
  late StoreCategoriesService storeCategoriesService;

  @override
  void initState() {
    superMarktsService = getIt<SuperMarktsService>();
    storeCategoriesService = getIt<StoreCategoriesService>();
    restaurantTypeService = getIt<RestaurantTypeService>();
    super.initState();
        superMarktConstants = SuperMarktConstants();
  }

  late final submitHandler = SuperMarktSubmitHandler(
    service: superMarktsService,
    imageService: ImageService(),
    collectionName: widget.collectionName,
    categoriesModel: formController.categoriesModel!,
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
        showAlertBar(context, superMarktConstants.getSaveSuccessText(context));
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
        showBtmAlert(context, superMarktConstants.getImageSelectionText());
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
        showBtmAlert(context, superMarktConstants.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, superMarktConstants.getImageSelectionErrorText());
    }
  }

  @override
  Widget build(BuildContext context) {
            var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: Size.width * 0.6,
                    //   height: Size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      //   color: AppColors.backgroundColor, //Colors.grey.withOpacity(0.3),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),

                            child: CustomDropDown(
                              onChanged: (CategoriesModel type) =>
                                  formController.categoriesModel = type,
                              service: storeCategoriesService,
                              title: 'Super Marchés Categories',
                            ),
                          ),
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),

                            child: CustomDropDown(
                              onChanged: (RestaurantTypeModel type) =>
                                  formController.selectedType = type,
                              service: restaurantTypeService,
                              title: 'Type de Store',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: superMarktConstants,
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
                        formController.webImage = null;
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
                        formController.weeklyHours = hours; // Or whatever handling you want
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
}
