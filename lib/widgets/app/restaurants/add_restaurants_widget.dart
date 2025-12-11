import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/util/restaurant_submit_handler.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/app/opens_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_drop_down.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:movegui_admin_panel/widgets/store_widget.dart';

class RestaurantAddWidgetPage extends StatefulWidget {
  const RestaurantAddWidgetPage({super.key});
  final String collectionName = 'restaurant';

  @override
  State createState() => _RestaurantAddWidgetPageState();
}

class _RestaurantAddWidgetPageState extends State<RestaurantAddWidgetPage> {
  final formController = StoreFormController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late RestaurantsService restaurantsService;
  late RestaurantTypeService restaurantTypeService;
  late List<OpenHours> weeklyHours;
  late RestaurantConstants restaurantConstants;

  @override
  void initState() {
    restaurantsService = getIt<RestaurantsService>();
    restaurantTypeService = getIt<RestaurantTypeService>();
    restaurantConstants = RestaurantConstants();
    super.initState();
    weeklyHours = [];
  }

  late final submitHandler = RestaurantSubmitHandler(
    service: restaurantsService,
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
      await submitHandler.submit(form: formController);
      showAlertBar(context, restaurantConstants.getSaveSuccessText());
    } catch (e) {
      showBtmAlert(context, e.toString());
    }

    setState(() => isLoading = false);
  }

  Future<void> pickAnImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          formController.pickedImage = selected;
        });
      } else {
        showBtmAlert(context, restaurantConstants.getImageSelectionText());
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          formController.webImage = f;
          formController.pickedImage = File('a');
        });
      } else {
        showBtmAlert(context, restaurantConstants.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, restaurantConstants.getImageSelectionErrorText());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: restaurantConstants.getMenuTitleText())
          : AdminPanelAppBar(title: restaurantConstants.getMenuTitleText()),
      drawer: SideMenu(),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SizedBox(
                    width: 400,
                    child: CustomDropDown(
                      onChanged: (RestaurantTypeModel type) =>
                          formController.selectedType = type,
                      service: restaurantTypeService,
                      title: 'Type Restaurants',
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: restaurantConstants,
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
                  child: AddContactWidget(),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: OpenHoursWidget(
                    onHoursChanged: (hours) {
                      setState(() {
                        print(
                          'hours is: ${hours.map((e) => (e.closeTime != null && e.openTime != null) ? e.toJson() : {}).toList()}',
                        );
                        weeklyHours = hours; // Or whatever handling you want
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

