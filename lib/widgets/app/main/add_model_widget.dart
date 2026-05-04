
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/model_service.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:uuid/uuid.dart';

class AddModelWidget extends StatefulWidget {
  const AddModelWidget({super.key});

  @override
  CategoriesUploaWidgetdstate createState() => CategoriesUploaWidgetdstate();

}


class CategoriesUploaWidgetdstate extends State<AddModelWidget> {


  GlobalKey<FormState> formKey = GlobalKey();
  double? price;
  String dropdownValue = 'vegetable';
  final int _selectedValue = 1;
  String unit = "KG";
  bool _isLoading = false;
  double? salePrice;
  bool showTextForm = false;
  bool isOnSale = false;
  late ModelService categoriesService;
  late TextEditingController _nameController;
  late FocusNode _nameFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  categoriesService = CategoriesService();
    _nameController = TextEditingController();
    _nameFocusNode = FocusNode();
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
                        height: Size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.backgroundColor//Colors.grey.withOpacity(0.3),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Ajouter une Categorie',
                                  style: TextStyle(
                                    fontSize: FontSize,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: AppColors.textColor
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
                                    child: CustomTextField(
                                      hasIcon: false,
                                      hintText: 'Veuillez saisir le nom de la Categorie',
                                      isNumber: false,
                                      controller: _nameController,
                                       textInputAction: TextInputAction.next,
                                       inputType: TextInputType.name,
                                       /*
                                      onChanged: (data) {
                                        name = data.trim();
                                      },
                                      */
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Le Nom est Obligatoire';
                                        }
                                        return null;
                                      },
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
                                        final category = CategoriesModel(id: uuid, name: _nameController.text, createdAt: DateTime.now(), );
                                        categoriesService.addModel(category);
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
                                    }else{
                                         setState(() {
                                    _isLoading = false;
                                  });
                                    }
                                  }
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
