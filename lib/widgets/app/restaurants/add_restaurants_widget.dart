import 'package:flutter/material.dart';


class RestaurantAddWidgetPage extends StatefulWidget {
  const RestaurantAddWidgetPage({super.key});
  final String collectionName = 'restaurant';

  @override
  State createState() => _RestaurantAddWidgetPageState();
}

class _RestaurantAddWidgetPageState extends State<RestaurantAddWidgetPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  
  /*
  final formController = StoreFormController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<AddContactWidgetState> addContactKey = GlobalKey();
  final GlobalKey<WeeklyHoursScreenState> addOpenHoursKey = GlobalKey();
  bool isLoading = false;
  late RestaurantsService restaurantsService;
  late RestaurantTypeService restaurantTypeService;
  // late List<OpenHours> weeklyHours;
  late RestaurantConstants restaurantConstants;

  @override
  void initState() {
    restaurantsService = getIt<RestaurantsService>();
    restaurantTypeService = getIt<RestaurantTypeService>();
    restaurantConstants = RestaurantConstants();
    super.initState();
    //  weeklyHours = [];
  }

  late final submitHandler = RestaurantSubmitHandler(
    service: restaurantsService,
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
      formController.contacts = await addContactKey.currentState!.getContacts();
      //  formController.weeklyHours = await addOpenHoursKey.currentState!.getOpenHours();
      if (formController.weeklyHours.isNotEmpty &&
          formController.contacts.isNotEmpty &&
          formController.selectedType != null) {
        await submitHandler.submit(form: formController);
        showAlertBar(context, restaurantConstants.getSaveSuccessText(context));
        addContactKey.currentState!.clear();
        addOpenHoursKey.currentState!.resetOpenHours();
        formController.clear();
        /*
        formController.dispose();
        addContactKey.currentState!.dispose();
        */
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
        showBtmAlert(context, restaurantConstants.getImageSelectionText());
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
        showBtmAlert(context, restaurantConstants.getImageSelectionText());
      }
    } else {
      showBtmAlert(context, restaurantConstants.getImageSelectionErrorText());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onChanged: (RestaurantTypeModel type) => {
                        setState(() {
                          formController.selectedType = type;
                        }),
                      },

                      service: restaurantTypeService,
                      title: 'Type Restaurants',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: StoreWidget(
                    storeConstants: restaurantConstants,
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
                        formController.webImage = null;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AddContactWidget(
                    key: addContactKey,
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
                    key: addOpenHoursKey,
                    onHoursChanged: (hours) {
                      setState(() {
                        formController.weeklyHours = hours;
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
  */
}
