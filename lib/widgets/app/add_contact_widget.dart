import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';
import 'package:movegui_admin_panel/widgets/add_person_widget.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class AddContactWidget extends StatefulWidget {
  const AddContactWidget({
    super.key,
    required this.formControllers,
 //   required this.addContactKey,
  });
  final List<PersonFormController> formControllers;
 // final GlobalKey<AddContactWidgetState> addContactKey;
  // final GlobalKey<WeeklyHoursScreenState> addOpenHoursKey = GlobalKey();

  @override
  AddContactWidgetState createState() => AddContactWidgetState();
}

class AddContactWidgetState extends State<AddContactWidget> {
  late ImageConstatnt imageConstatnt;

  @override
  void initState() {
    super.initState();
    imageConstatnt = ImageConstatnt();
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
      widget.formControllers[index].webImage = null;
      widget.formControllers[index].pickedImage = null;
    });
  }

  Future<void> _addPerson() async {
    setState(() {
      widget.formControllers.add(PersonFormController());
    });
    //  updateParent();
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
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;
    return ListView.separated(
    //  key: widget.addContactKey,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.formControllers.length,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
            width: Responsive.isDesktop(context)
                ? Size.width * 0.5
                : double.infinity,
            //   height: Size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.backgroundColor, //Colors.grey.withOpacity(0.3),
            ),
            child: Column(
              children: [
                AddPersonWidget(
                  onGenderChanged: (value) {
                    setState(
                      () => widget.formControllers[index].gender = value!,
                    );
                  },
                  onBirthDateChanged: (value) {
                    setState(
                      () => widget.formControllers[index].birthdate = value!,
                    );
                  },
                  onPickImage: () {
                    pickAnImage(index);
                  },
                  onRemoveImage: () {
                    setState(() {
                      widget.formControllers[index].pickedImage = null;
                      widget.formControllers[index].webImage = null;
                    });
                  },
                  onAdressTypeChange: (String? selectedValue) {
                    setState(() {
                      widget.formControllers[index].addressesForms[0].selectedType =
                          selectedValue!;
                    });
                  },

                  onCommuneChange: (String? value) {
                    setState(() {
                      widget
                              .formControllers[index]
                              .addressesForms[0]
                              .selectedMunicipality =
                          value!;
                    });
                  },

                  personForm: widget.formControllers[index],
                  personKey: personKey,
                  addAddressKey: addressKey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        onPressed: (item) async {
                          _addPerson();
                        },
                        buttonItem: ButtonItem(
                          AppLocalizations.of(context)!.btn_add_contact,
                          onPress: () {},
                          tooltipText: AppLocalizations.of(
                            context,
                          )!.tooltip_btn_add_contact,
                          enabled: true,
                          routeName: '',
                        ),
                        icon: Icons.add,
                        backgroundColor: AppColors.darkPrimary,
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
          //  widget.pickedImage = selected;
          widget.formControllers[index].pickedImage = selected;
          //  widget.formControllers[index].image = selected;
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
          widget.formControllers[index].webImage = f;
          widget.formControllers[index].pickedImage = File('a');
        });
      } else {
        showBtmAlert(context, imageConstatnt.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, imageConstatnt.getImageSelectionErrorText());
    }
  }
}
