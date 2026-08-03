import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/user_form_controller.dart';
import 'package:movegui_admin_panel/widgets/add_person_widget.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class AddContactWidget extends StatefulWidget {
  const AddContactWidget({super.key, required this.formControllers});
  final List<UserFormController> formControllers;

  @override
  AddContactWidgetState createState() => AddContactWidgetState();
}

class AddContactWidgetState extends State<AddContactWidget> {
  late ImageConstatnt imageConstatnt;
  late SeedService seedService;

  @override
  void initState() {
    super.initState();
    imageConstatnt = ImageConstatnt();
    seedService = getIt<SeedService>();
  }

  final GlobalKey<FormState> personKey = GlobalKey();
  final GlobalKey<FormState> addressKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < widget.formControllers.length; i++) {
      widget.formControllers[i].dispose();
    }
  }

  void clear(int index) {
    widget.formControllers[index].clear();
    setState(() {
      widget.formControllers[index].personForm.webImage = null;
      widget.formControllers[index].personForm.pickedImage = null;
    });
  }

  Future<void> _addPerson() async {
    UserModel? personTestData;

    if (seedService.api.env is EnvDev) {
      personTestData = await seedService.getGeneratedUserModel();
    }

    setState(() {
      widget.formControllers.add(UserFormController());

      if (personTestData != null) {
        widget.formControllers.last.setData(personTestData);
      }
    });
  }

  void _removePerson(int index) {
    if (widget.formControllers.length == 1) return;
    remove(index);
  }

  void remove(int index) {
    setState(() {
      widget.formControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.formControllers.length,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
            width: Responsive.isDesktop(context)
                ? size.width * 0.5
                : double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
             
            ),
            child: Column(
              children: [
                AddPersonWidget(
                  onGenderChanged: (value) {
                    setState(
                      () => widget.formControllers[index].personForm.gender = value!,
                    );
                  },
                  onBirthDateChanged: (value) {
                    setState(
                      () => widget.formControllers[index].personForm.birthdate = value!,
                    );
                  },
                  onPickImage: () {
                    pickAnImage(index);
                  },
                  onRemoveImage: () {
                    setState(() {
                      widget.formControllers[index].personForm.pickedImage = null;
                      widget.formControllers[index].personForm.webImage = null;
                    });
                  },
                  onAdressTypeChange: (String? selectedValue) {
                    setState(() {
                      widget
                              .formControllers[index]
                              .personForm.addressesForms[0]
                              .selectedType =
                          selectedValue!;
                    });
                  },

                  onCommuneChange: (String? value) {
                    setState(() {
                      widget
                              .formControllers[index]
                              .personForm.addressesForms[0]
                              .selectedMunicipality =
                          value!;
                    });
                  },

                  personForm: widget.formControllers[index].personForm,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        onPressed: (item) async {
                          _addPerson();
                        },
                        buttonItem: ButtonInfo(
                          title: AppLocalizations.of(context)!.btn_add_contact,
                          enabled: true,
                          routeName: '',
                        ),
                        icon: Icons.add,
                      
                      ),
                    ),

                    Expanded(
                      child: IconButton(
                        onPressed: () => _removePerson(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                SeparatorWidget(height: WidgetConstants.sepWidget),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: WidgetConstants.sepWidget);
      },
    );
  }

  Future<void> pickAnImage(int index) async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          widget.formControllers[index].personForm.pickedImage = selected;
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
          widget.formControllers[index].personForm.webImage = f;
          widget.formControllers[index].personForm.pickedImage = File('a');
        });
      } else {
        showBtmAlert(context, imageConstatnt.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, imageConstatnt.getImageSelectionErrorText());
    }
  }
}
