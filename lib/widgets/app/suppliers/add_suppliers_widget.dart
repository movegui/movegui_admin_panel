import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/supplier_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/suppliers_service.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:uuid/uuid.dart';

/*
class AddSuppliersWidget extends MainScreen {
  const AddSuppliersWidget({super.key, required super.pageScreen});
}
*/

class SupplierAddWidgetPage extends StatefulWidget {
  const SupplierAddWidgetPage({super.key});

  @override
  SuppliersUploaWidgetdstate createState() => SuppliersUploaWidgetdstate();
}

class SuppliersUploaWidgetdstate extends State<SupplierAddWidgetPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  double? price;
  String dropdownValue = 'vegetable';
  int? _selectedValue = 1;
  String unit = "KG";
  bool _isLoading = false;
  double? salePrice;
  bool showTextForm = false;
  bool isOnSale = false;
  late SuppliersService suppliersService;
  late TextEditingController _nameController;
  late TextEditingController _adresseController;
  late TextEditingController _telephonController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  late TextEditingController _companyController;
  late TextEditingController _typeController;

  late FocusNode _nameFocusNode;
  late FocusNode _adresseFocusNode;
  late FocusNode _telephonFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _contactFocusNode;
  late FocusNode _companyFocusNode;
  late FocusNode _typeFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suppliersService =  getIt<SuppliersService>();//SuppliersService();
    _nameController = TextEditingController();
    _adresseController = TextEditingController();
    _telephonController = TextEditingController();
    _emailController = TextEditingController();
    _contactController = TextEditingController();
    _companyController = TextEditingController();
    _typeController = TextEditingController();

    _nameFocusNode = FocusNode();
    _adresseFocusNode = FocusNode();
    _telephonFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _contactFocusNode = FocusNode();
    _companyFocusNode = FocusNode();
    _typeFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;

    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? AdminPanelAppBarDesktop(title: 'Ajouter une categorie')
          : AdminPanelAppBar(title: 'Ajouter une categorie'),
      drawer: SideMenu(),
      body: Builder(
        builder: (context) => SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
              if (Responsive.isDesktop(context))
                const Expanded(child: SideMenu()),
                */
              Expanded(
                flex: 5,
                child: ModalProgressHUD(
                  inAsyncCall: _isLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Container(
                        width: Size.width * 0.4,
                        //   height: Size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors
                              .backgroundColor, //Colors.grey.withOpacity(0.3),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Ajouter un Fournisseur:',
                                  style: TextStyle(
                                    fontSize: FontSize,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: AppColors.textColor,
                                    decorationColor: AppColors.textColor,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Responsive.isDesktop(context)
                                        ? Size.width * 0.3
                                        : Size.width * 0.4,
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir le nom du Fournisseur',
                                          isNumber: false,
                                          controller: _nameController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _companyFocusNode,
                                          labelText: 'Nom du Fournisseur',
                                          icon: Icons.home,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),

                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir l\'entreprise du Fournisseur',
                                          isNumber: false,
                                          controller: _companyController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _typeFocusNode,
                                          labelText: ' l\'entreprise du Fournisseur',
                                          icon: Icons.business_center,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir le type de Fournisseur',
                                          isNumber: false,
                                          controller: _typeController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _adresseFocusNode,
                                          labelText: ' le type de Fournisseur',
                                          icon: Icons.business_sharp,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),

                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir l\'adresse du Fournisseur',
                                          isNumber: false,
                                          controller: _adresseController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _emailFocusNode,
                                          labelText: ' l\'adresse du Fournisseur',
                                          icon: Icons.home,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir l\'email du Fournisseur',
                                          isNumber: false,
                                          controller: _emailController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _telephonFocusNode,
                                          labelText: ' l\'email du Fournisseur',
                                          icon: Icons.email,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            return MyValidators.emailValidator(
                                              value,
                                            );
                                          },
                                        ),
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir le telephone du Fournisseur',
                                          isNumber: false,
                                          controller: _telephonController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          nextFocusNode: _contactFocusNode,
                                          labelText: ' le telephone du Fournisseur',
                                          icon: Icons.phone,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            return MyValidators.phoneNumberValidator(
                                              value,
                                            );
                                          },
                                        ),
                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir la personne de Contact du Fournisseur',
                                          isNumber: false,
                                          controller: _contactController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          labelText: ' Personne de contact',
                                          icon: Icons.person,

                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            MyValidators.textValidator(value);
                                          },
                                        ),

                                        SizedBox(width: 6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              CustomButon(
                                text: 'Enregistrer',
                                icon: Icons.upload,
                                onTap: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  String? imageUrl;
                                  final form = formKey.currentState;
                                  if (form != null && form.validate()) {
                                    form.save();
                                    final _uuid = const Uuid().v4();
                                    try {
                                      final supplier = SupplierModel(
                                        id: _uuid,
                                        name: _nameController.text,
                                        createdAt: DateTime.now(),
                                        adresse: _adresseController.text,
                                        telephon: _telephonController.text,
                                        email: _emailController.text,
                                        contact: _contactController.text,
                                        company: _companyController.text,
                                        type: _typeController.text,
                                      );
                                      suppliersService.addModel(supplier);
                                      setState(() {
                                        _nameController.clear();
                                        _adresseController.clear();
                                        _telephonController.clear();
                                        _emailController.clear();
                                        _contactController.clear();
                                        _companyController.clear();
                                        _typeController.clear();
                                        _nameFocusNode.requestFocus();
                                      });
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showAlertBar(
                                        context,
                                        'Nouveau Fournisseur Ajouter avec succes!',
                                      );
                                    } on FirebaseException catch (e) {
                                      showBtmAlert(
                                        context,
                                        e.message.toString(),
                                      );
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
