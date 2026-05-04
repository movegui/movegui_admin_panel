import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/store_categories_service.dart';
import 'package:movegui_admin_panel/widgets/app/admin_panel_appbar.dart';
import 'package:movegui_admin_panel/widgets/custom_button.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/side_menu.dart';
import 'package:uuid/uuid.dart';

class StoreCategoriesAddWidgetPage extends StatefulWidget {
  const StoreCategoriesAddWidgetPage({super.key});

  @override
  State<StatefulWidget> createState() => StoreCategoriesUploaWidgetdstate();
}

class StoreCategoriesUploaWidgetdstate
    extends State<StoreCategoriesAddWidgetPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool _isLoading = false;

  late StoreCategoriesService storeCategoriesService;
  late TextEditingController _nameController;
  late FocusNode _nameFocusNode;
  late StoreCategoriesConstants storeCategoriesConstants;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeCategoriesService =
        getIt<StoreCategoriesService>(); //CategoriesService();
    _nameController = TextEditingController();
    _nameFocusNode = FocusNode();
    storeCategoriesConstants = StoreCategoriesConstants();
  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;

    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                  storeCategoriesConstants.getTitle(),
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
                                    child: CustomTextField(
                                      hasIcon: false,
                                      hintText: storeCategoriesConstants
                                          .getHinterText(),
                                      isNumber: false,
                                      controller: _nameController,
                                      textInputAction: TextInputAction.next,
                                      inputType: TextInputType.name,
                                      labelText: storeCategoriesConstants
                                          .getLabelText(),
                                      icon: Icons.person,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return storeCategoriesConstants
                                              .getNaameValidatorText();
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
                                onTap: _saveStorecategory,
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

  Future<void> _saveStorecategory() async {
    {
      setState(() {
        _isLoading = true;
      });
      String? imageUrl;
      final form = formKey.currentState;
      if (form != null && form.validate()) {
        form.save();
        final uuid = const Uuid().v4();
        try {
          final category = CategoriesModel(
            id: uuid,
            name: _nameController.text,
            createdAt: DateTime.now(),
          );
          storeCategoriesService.addModel(category);
          setState(() {
            _nameController.clear();
            _nameFocusNode.requestFocus();
          });
          setState(() {
            _isLoading = false;
          });
          showAlertBar(context, storeCategoriesConstants.getSaveSuccessText());
        } on FirebaseException catch (e) {
          showBtmAlert(context, e.message.toString());
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
    }
  }
}
