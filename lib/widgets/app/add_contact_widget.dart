import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/user_form_controller.dart';
import 'package:movegui_admin_panel/widgets/add_person_widget.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/dashboard_header.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';

class AddContactWidget extends StatefulWidget {
  final List<UserFormController> formControllers;
  final String title;
  final String subTitle;
  final String? buttonTitle;
  final ValueChanged<UserFormController>? onFormControllerAdded;

  const AddContactWidget({
    super.key,
    required this.formControllers,
    required this.title,
    required this.subTitle,
    this.buttonTitle,
    this.onFormControllerAdded,
  });

  @override
  AddContactWidgetState createState() => AddContactWidgetState();
}

class AddContactWidgetState extends State<AddContactWidget> {
  late ImageConstatnt imageConstatnt;
  late SeedService seedService;
  final GlobalKey _newPersonKey = GlobalKey();
  //final addContactKey = GlobalKey<AddContactWidgetState>();

  @override
  void initState() {
    super.initState();
    imageConstatnt = ImageConstatnt();
    seedService = getIt<SeedService>();
  }

  @override
  void dispose() {
    super.dispose();
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

    final role = widget.formControllers.last.role;
    final newPerson = UserFormController();
    if (personTestData != null) {
      await newPerson.setData(personTestData);
    }
    newPerson.role = role;
    widget.onFormControllerAdded?.call(newPerson);

    setState(() => widget.formControllers.add(newPerson));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToNewestPerson();
    });
  }

  void scrollToNewestPerson() {
    final newPersonContext = _newPersonKey.currentContext;
    if (newPersonContext == null) return;

    Scrollable.ensureVisible(
      newPersonContext,
      alignment: 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          DashboardHeader(
            title: widget.title,
            subtitle: widget.subTitle,
            onPressed: (item) async {
              await _addPerson();
            },
            buttonText:
                widget.buttonTitle ?? AppLocalizations.of(context)!.btn_create,
          ),
          SizedBox(height: WidgetConstants.sepWidget),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.formControllers.length,
            itemBuilder: (context, index) {
              final user = widget.formControllers[index];
              return Form(
                key: user.formKey,
                child: Center(
                  key: index == widget.formControllers.length - 1
                      ? _newPersonKey
                      : null,
                  child: Column(
                    children: [
                      AddPersonWidget(
                        onGenderChanged: (value) {
                          setState(() => user.personForm.gender = value!);
                        },
                        onBirthDateChanged: (value) {
                          setState(() => user.personForm.birthDate = value!);
                        },
                        onPickImage: () {
                          pickAnImage(index);
                        },
                        onRemoveImage: () {
                          setState(() {
                            user.personForm.pickedImage = null;
                            widget.formControllers[index].personForm.webImage =
                                null;
                          });
                        },
                        onAdressTypeChange: (String? selectedValue) {
                          setState(() {
                            user.personForm.adressesForms[0].selectedType =
                                selectedValue!;
                          });
                        },
                        onCommuneChange: (String? value) {
                          setState(() {
                            user
                                    .personForm
                                    .adressesForms[0]
                                    .selectedMunicipality =
                                value!;
                          });
                        },
                        personForm: user.personForm,
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
          ),
        ],
      ),
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
