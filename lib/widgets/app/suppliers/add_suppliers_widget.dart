
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:movegui_admin_panel/services/suppliers_service.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/util/supplier_submit_handler.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/app/opens_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_drop_down.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:movegui_admin_panel/widgets/store_widget.dart';


/*
class AddSuppliersWidget extends MainScreen {
  const AddSuppliersWidget({super.key, required super.pageScreen});
}
*/

class SupplierAddWidgetPage extends StatefulWidget {
  const SupplierAddWidgetPage({super.key});
  final String collectionName = 'suppliers';

  @override
  SuppliersUploaWidgetdstate createState() => SuppliersUploaWidgetdstate();
}

class SuppliersUploaWidgetdstate extends State<SupplierAddWidgetPage> {


 final formController = StoreFormController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late SuppliersService suppliersService;
  late RestaurantTypeService restaurantTypeService;
  late List<OpenHours> weeklyHours;
  late SupplierConstants supplierConstants;

  @override
  void initState() {
    suppliersService = getIt<SuppliersService>();
    restaurantTypeService = getIt<RestaurantTypeService>();
    supplierConstants = SupplierConstants();
    super.initState();
    weeklyHours = [];
  }

  late final submitHandler = SupplierSubmitHandler(
    service: suppliersService,
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
      showAlertBar(context, supplierConstants.getSaveSuccessText());
    } catch (e) {
      showBtmAlert(context, e.toString());
    }

    setState(() => isLoading = false);
  }

  void pickAnImage() async {
   final result = await ImageService.pickAnImage();
   if(result == null){
     showBtmAlert(context, supplierConstants.getImageSelectionText());
    return;
   }
     setState(() {
    formController.pickedImage = result['file'];
    formController.webImage = result["webImage"];
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: supplierConstants.getMenuTitleText())
          : AdminPanelAppBar(title: supplierConstants.getMenuTitleText()),
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
                      title: 'Types Fournisseurs',
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: supplierConstants,
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
