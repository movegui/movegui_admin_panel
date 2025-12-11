import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/patisserie_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/categories_service.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/patisseries_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/store_categories_service.dart';
import 'package:movegui_admin_panel/util/patisserie_submit_handler.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/app/opens_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_drop_down.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:movegui_admin_panel/widgets/store_widget.dart';
import 'package:uuid/uuid.dart';

class PatisserieAddWidgetPage extends StatefulWidget {
  const PatisserieAddWidgetPage({super.key});
  final String collectionName = 'patisserie';

  @override
  State<StatefulWidget> createState() => PatisserieAddWidgetPageState();
}

class PatisserieAddWidgetPageState extends State<PatisserieAddWidgetPage> {
  final formController = StoreFormController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late PatisseriesService patisseriesService;
  late RestaurantTypeService restaurantTypeService;
  late StoreCategoriesService storeCategoriesService;
  late List<OpenHours> weeklyHours;
  late PatisserieConstants patisserieConstants;

  @override
  void initState() {
    patisseriesService = getIt<PatisseriesService>();
    restaurantTypeService = getIt<RestaurantTypeService>();
    storeCategoriesService = getIt<StoreCategoriesService>();
    patisserieConstants = PatisserieConstants();
    super.initState();
    weeklyHours = [];
  }

  late final submitHandler = PatisserieSubmitHandler(
    service: patisseriesService,
    imageService: ImageService(),
    collectionName: widget.collectionName,
    categoriesModel: formController.categoriesModel,
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
      showAlertBar(context, patisserieConstants.getSaveSuccessText());
    } catch (e) {
      showBtmAlert(context, e.toString());
    }

    setState(() => isLoading = false);
  }

  void pickAnImage() async {
    final result = await ImageService.pickAnImage();
    if (result == null) {
      showBtmAlert(context, patisserieConstants.getImageSelectionText());
      return;
    }
    setState(() {
      formController.pickedImage = result['file'];
      formController.webImage = result["webImage"];
    });
  }

  @override
  Widget build(BuildContext context) {
        var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: patisserieConstants.getMenuTitleText())
          : AdminPanelAppBar(title: patisserieConstants.getMenuTitleText()),
      drawer: SideMenu(),
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
        child:
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                            
                            child: CustomDropDown(
                              onChanged: (CategoriesModel type) =>
                                  formController.categoriesModel = type,
                              service: storeCategoriesService,
                              title: 'Patisserie Categories',
                            ),
                        
                        ),
                      
                    ),
                    SizedBox(width: 3,),
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
      )
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: patisserieConstants,
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
