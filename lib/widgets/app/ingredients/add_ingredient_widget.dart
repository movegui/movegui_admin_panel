import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/ingredient_model.dart';
import 'package:movegui_admin_panel/models/supplier_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/categories_service.dart';
import 'package:movegui_admin_panel/services/ingredients_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/suppliers_service.dart';
import 'package:movegui_admin_panel/widgets/app/appbar.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_drop_down.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/radio_btns%20copy.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:uuid/uuid.dart';

class IngredientsAddWidgetPage extends StatefulWidget {
  const IngredientsAddWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => IngredientsUploaWidgetdstate();
}

class IngredientsUploaWidgetdstate extends State<IngredientsAddWidgetPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  double? price;
  String dropdownValue = 'vegetable';
  int? _selectedValue = 1;
  String unit = "KG";
  bool _isLoading = false;
  double? salePrice;
  bool showTextForm = false;
  bool isOnSale = false;
  late IngredientsService ingredientsService;
  late CategoriesService categoriesService;
  late SuppliersService suppliersService;
  late TextEditingController _nameController;
  late FocusNode _nameFocusNode;
  CategoriesModel? selectedcategorie;
  SupplierModel? selectedSupplier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _nameFocusNode = FocusNode();
    categoriesService = getIt<CategoriesService>();
    suppliersService = getIt<SuppliersService>();
    ingredientsService = getIt<IngredientsService>();
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
                        //  height: Size.height * 0.3,
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
                                  'Ajouter un Ingredient',
                                  style: TextStyle(
                                    fontSize: FontSize,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: AppColors.textColor,
                                    decorationColor: AppColors.textColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Responsive.isDesktop(context)
                                        ? Size.width * 0.3
                                        : Size.width * 0.4,

                                    child: Column(
                                      children: [
                                        Responsive.isDesktop(context)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // Start-aligned dropdown
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Categories options',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .textColor,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      CustomDropDown(
                                                        service:
                                                            categoriesService,
                                                        onChanged:
                                                            (
                                                              CategoriesModel?
                                                              newValue,
                                                            ) {
                                                              setState(() {
                                                                selectedcategorie =
                                                                    newValue;
                                                              });
                                                            },
                                                            title: 'Ingredients Type',
                                                      ),
                                                    ],
                                                  ),

                                                  // End-aligned dropdown
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'Suppliers options',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .textColor,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      CustomDropDown(
                                                        service:
                                                            SuppliersService(),
                                                        onChanged:
                                                            (
                                                              SupplierModel
                                                              newValue,
                                                            ) {
                                                              setState(() {
                                                                selectedSupplier =
                                                                    newValue;
                                                              });
                                                            },
                                                              title: 'Ingredients Type',
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,

                                                children: [
                                                  SizedBox(height: 18),
                                                  Text(
                                                    'Categories options',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.textColor,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  CustomDropDown(
                                                    service: categoriesService,
                                                    onChanged:
                                                        (
                                                          CategoriesModel?
                                                          newValue,
                                                        ) {
                                                          setState(() {
                                                            selectedcategorie =
                                                                newValue;
                                                          });
                                                        },
                                                          title: 'Ingredients Type',
                                                  ),

                                                  SizedBox(height: 18),
                                                  Text(
                                                    'Categories options',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.textColor,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  CustomDropDown(
                                                    service: SuppliersService(),
                                                    onChanged:
                                                        (
                                                          SupplierModel
                                                          newValue,
                                                        ) {
                                                          setState(() {
                                                            selectedSupplier =
                                                                newValue;
                                                          });
                                                        },
                                                          title: 'Ingredients Type',
                                                  ),
                                                ],
                                              ),
                                        SizedBox(height: 8),

                                        CustomTextField(
                                          hasIcon: false,
                                          hintText:
                                              'Veuillez saisir le nom de l\'ingredient',
                                          isNumber: false,
                                          controller: _nameController,
                                          textInputAction: TextInputAction.next,
                                          inputType: TextInputType.name,
                                          labelText: 'Nom',
                                          icon: Icons.person,
                                          /*
                                          onChanged: (data) {
                                            name = data.trim();
                                          },
                                          */
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Le Nom est Obligatoire';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Unité de Mesure',
                                          style: TextStyle(fontSize: FontSize, color: AppColors.textColor),
                                        ),
                                        MyRadioBtn(
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedValue = value;
                                              if (_selectedValue == 1) {
                                                unit = 'Kg';
                                              } else if(_selectedValue == 2) {
                                                unit = 'piece';
                                              } else{
                                                unit = 'litre';
                                              }
                                            });
                                          },
                                        ),
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
                                    final uuid = const Uuid().v4();
                                    try {
                                     final ingredient = IngredientModel(
                                      id: uuid, 
                                      name: _nameController.text, 
                                      unit: unit, 
                                      isAllergic: false, 
                                      category: selectedcategorie, 
                                      supplier: selectedSupplier, 
                                      createdAt: DateTime.now()
                                      );
                                      await ingredientsService.addModel(ingredient);
                                     print('categrie: ${ingredient.category.toString()}');
                                      setState(() {
                                        _nameController.clear();
                                        _nameFocusNode.requestFocus();
                                      });
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showAlertBar(
                                        context,
                                        'Novelle Categorie Ajouter avec succes!',
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
