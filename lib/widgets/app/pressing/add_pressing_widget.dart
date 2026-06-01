import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/methods/show_alert.dart';
import 'package:movegui_admin_panel/models/button_item.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/pressing_form_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/pressing_form_controller.dart';
import 'package:movegui_admin_panel/util/pressing_submit_handler.dart';
import 'package:movegui_admin_panel/widgets/app/auth/validation_button.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_service_widget.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_widget.dart';

class AddPressingWidget extends StatefulWidget {
  const AddPressingWidget({super.key});
  final String collectionName = 'pressings';

  @override
  State<StatefulWidget> createState() => PressingAddWidgetPageState();
}

class PressingAddWidgetPageState extends State<AddPressingWidget> {
  final formController = PressingFormController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late PressingService pressingService;
  late PressingFormService formService;
  late SeedService seedService;
  late UserService userService;

  @override
  void initState() {
    pressingService = getIt<PressingService>();
    formService = getIt<PressingFormService>();
    seedService = getIt<SeedService>();
    userService = getIt<UserService>();

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final service = await seedService.getGeneratedPressingService();
    formController.services.add(service);
    await loadDatatest();
    // code ici
  }

  Future<void> loadDatatest() async {
    if (seedService.api.env is EnvDev) {
      final pressingTestData = await seedService.generatePressing();
      setState(() {
        formController.setData(pressingTestData);
      });
    }
  }

  late final submitHandler = PressingSubmitHandler(
    service: pressingService,
    imageService: ImageService(),
    collectionName: widget.collectionName,
    formService: formService,
    userService: userService,
    context: context,
  );

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!formKey.currentState!.validate() ||
        formController.pickedImage == null ||
        formController.personForms.any(
          (elem) =>
              elem.pickedImage == null ||
              elem.birthdate == null ||
              elem.gender == null,
        )) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_title,
        AppLocalizations.of(context)!.error_send_formular,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      formController.contacts = await formService.getContacts(
        formController.personForms,
      );

      if (formController.weeklyHours.isNotEmpty &&
          formController.contacts.isNotEmpty) {
        await submitHandler.submit(form: formController);
        showAlertBar(
          context,
          AppLocalizations.of(context)!.store_add_success_message(
            AppLocalizations.of(context)!.category_pressing_name,
          ),
        );
      }
    } catch (e) {
      showBtmAlert(context, e.toString());
    }

    setState(() => isLoading = false);
  }

  Future<void> pickAnImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          formController.pickedImage = selected;
        });
      } else {
        showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          formController.webImage = f;
          formController.pickedImage = File('a');
        });
      } else {
        showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
      }
    } else {
      showBtmAlert(context, AppLocalizations.of(context)!.error_occur);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: PressingConstants(),
                    formController: formController,
                    onPickImage: pickAnImage,
                    onRemoveImage: () {
                      setState(() {
                        formController.pickedImage = null;
                        formController.webImage = Uint8List(8);
                      });
                    },
                    onAdressTypeChange: (String? value) {
                      setState(() {
                        formController.addressForm.selectedType = value!;
                      });
                    },
                    onCommuneChange: (String? value) {
                      formController.addressForm.selectedMunicipality = value!;
                    },
                    textColor: AppColors.textColor,
                    onHoursChanged: (List<OpenHoursModel> hours) {
                      formController.weeklyHours = hours;
                    },
                  ),
                ),

                PressingServiceWidget(
                  formControllers: formController.serviceForms,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ValidationButton(
                    fn: (item) async {
                      await _onSubmit();
                    },
                    buttonItem: ButtonItem(
                      AppLocalizations.of(context)!.btn_register_label,
                      onPress: () {},
                      tooltipText: AppLocalizations.of(
                        context,
                      )!.tooltip_registration,
                      enabled: true,
                      routeName: '',
                    ),
                    icon: Icons.save,
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
