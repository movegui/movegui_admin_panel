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

  const AddContactWidget({
    super.key,
    required this.formControllers,
    required this.title,
    required this.subTitle,
    this.buttonTitle,
  });

  @override
  AddContactWidgetState createState() => AddContactWidgetState();
}

class AddContactWidgetState extends State<AddContactWidget> {
  late ImageConstatnt imageConstatnt;
  late SeedService seedService;
  final GlobalKey _newPersonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    imageConstatnt = ImageConstatnt();
    seedService = getIt<SeedService>();
  }

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newPersonContext = _newPersonKey.currentContext;
      if (newPersonContext != null) {
        Scrollable.ensureVisible(
          newPersonContext,
          alignment: 1,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
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
              return Center(
                key: index == widget.formControllers.length - 1
                    ? _newPersonKey
                    : null,
                child: Column(
                  children: [
                    AddPersonWidget(
                      onGenderChanged: (value) {
                        setState(
                          () =>
                              widget.formControllers[index].personForm.gender =
                                  value!,
                        );
                      },
                      onBirthDateChanged: (value) {
                        setState(
                          () =>
                              widget
                                      .formControllers[index]
                                      .personForm
                                      .birthdate =
                                  value!,
                        );
                      },
                      onPickImage: () {
                        pickAnImage(index);
                      },
                      onRemoveImage: () {
                        setState(() {
                          widget.formControllers[index].personForm.pickedImage =
                              null;
                          widget.formControllers[index].personForm.webImage =
                              null;
                        });
                      },
                      onAdressTypeChange: (String? selectedValue) {
                        setState(() {
                          widget
                                  .formControllers[index]
                                  .personForm
                                  .addressesForms[0]
                                  .selectedType =
                              selectedValue!;
                        });
                      },
                      onCommuneChange: (String? value) {
                        setState(() {
                          widget
                                  .formControllers[index]
                                  .personForm
                                  .addressesForms[0]
                                  .selectedMunicipality =
                              value!;
                        });
                      },
                      personForm: widget.formControllers[index].personForm,
                    ),
                    SeparatorWidget(height: WidgetConstants.sepWidget),
                  ],
                ),
                //     ),
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
