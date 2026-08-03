import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @commune_title.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get commune_title;

  /// No description provided for @gender_masculin.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_masculin;

  /// No description provided for @gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female;

  /// No description provided for @open_hours_title.
  ///
  /// In en, this message translates to:
  /// **'Open Hours'**
  String get open_hours_title;

  /// No description provided for @store_services_title.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get store_services_title;

  /// No description provided for @is_loding_text.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get is_loding_text;

  /// No description provided for @admin_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Admin Configuration'**
  String get admin_bar_title;

  /// No description provided for @admin_add_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Add Admin'**
  String get admin_add_bar_title;

  /// No description provided for @admin_all_bar_title.
  ///
  /// In en, this message translates to:
  /// **'All Admins'**
  String get admin_all_bar_title;

  /// No description provided for @employe_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Employe Configuration'**
  String get employe_bar_title;

  /// No description provided for @employe_add_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Add Employe'**
  String get employe_add_bar_title;

  /// No description provided for @employe_all_bar_title.
  ///
  /// In en, this message translates to:
  /// **'All Employes'**
  String get employe_all_bar_title;

  /// No description provided for @employe_status_actf.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get employe_status_actf;

  /// No description provided for @employe_status_non_actf.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get employe_status_non_actf;

  /// No description provided for @manager_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Manager Configuration'**
  String get manager_bar_title;

  /// No description provided for @manager_add_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Add Manager'**
  String get manager_add_bar_title;

  /// No description provided for @manager_all_bar_title.
  ///
  /// In en, this message translates to:
  /// **'All Manager'**
  String get manager_all_bar_title;

  /// No description provided for @manager_status_actf.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get manager_status_actf;

  /// No description provided for @manager_status_non_actf.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get manager_status_non_actf;

  /// No description provided for @driver_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Driver Configuration'**
  String get driver_bar_title;

  /// No description provided for @driver_add_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Add Driver'**
  String get driver_add_bar_title;

  /// No description provided for @driver_all_bar_title.
  ///
  /// In en, this message translates to:
  /// **'All Drivers'**
  String get driver_all_bar_title;

  /// No description provided for @driver_status_actf.
  ///
  /// In en, this message translates to:
  /// **'Actif'**
  String get driver_status_actf;

  /// No description provided for @driver_status_non_actf.
  ///
  /// In en, this message translates to:
  /// **'Inactif'**
  String get driver_status_non_actf;

  /// No description provided for @pressing_add_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Add dry Cleaner '**
  String get pressing_add_bar_title;

  /// No description provided for @pressing_all_bar_title.
  ///
  /// In en, this message translates to:
  /// **'All Dry Cleaners '**
  String get pressing_all_bar_title;

  /// No description provided for @pressing_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Configuration dry Cleaner '**
  String get pressing_bar_title;

  /// No description provided for @pressing_service_washing.
  ///
  /// In en, this message translates to:
  /// **'Washing'**
  String get pressing_service_washing;

  /// No description provided for @pressing_service_dry_cleaning.
  ///
  /// In en, this message translates to:
  /// **'Dry Cleaning'**
  String get pressing_service_dry_cleaning;

  /// No description provided for @pressing_service_ironing.
  ///
  /// In en, this message translates to:
  /// **'Ironing'**
  String get pressing_service_ironing;

  /// No description provided for @pressing_service_laundry.
  ///
  /// In en, this message translates to:
  /// **'Laundry '**
  String get pressing_service_laundry;

  /// No description provided for @pressing_service_folding.
  ///
  /// In en, this message translates to:
  /// **'Folding'**
  String get pressing_service_folding;

  /// No description provided for @pressing_service_stain_removal.
  ///
  /// In en, this message translates to:
  /// **'Stain Removal'**
  String get pressing_service_stain_removal;

  /// No description provided for @pressing_service_service_express.
  ///
  /// In en, this message translates to:
  /// **'Service express'**
  String get pressing_service_service_express;

  /// No description provided for @pressing_service_home_laundry.
  ///
  /// In en, this message translates to:
  /// **'Home Laundry'**
  String get pressing_service_home_laundry;

  /// No description provided for @pressing_service_work_clothing.
  ///
  /// In en, this message translates to:
  /// **'Care of Work Clothing'**
  String get pressing_service_work_clothing;

  /// No description provided for @pressing_service_delicate_fabrics.
  ///
  /// In en, this message translates to:
  /// **'Care of Delicate Fabrics'**
  String get pressing_service_delicate_fabrics;

  /// No description provided for @pressing_service_washing_descrip.
  ///
  /// In en, this message translates to:
  /// **'Washing clothes with water'**
  String get pressing_service_washing_descrip;

  /// No description provided for @pressing_service_dry_cleaning_descrip.
  ///
  /// In en, this message translates to:
  /// **'Special cleaning for delicate fabrics'**
  String get pressing_service_dry_cleaning_descrip;

  /// No description provided for @pressing_service_ironing_descrip.
  ///
  /// In en, this message translates to:
  /// **'Remove wrinkles with an iron or a press'**
  String get pressing_service_ironing_descrip;

  /// No description provided for @pressing_service_laundry_descrip.
  ///
  /// In en, this message translates to:
  /// **'Full-service laundry and dry cleaning'**
  String get pressing_service_laundry_descrip;

  /// No description provided for @pressing_service_folding_descrip.
  ///
  /// In en, this message translates to:
  /// **'Clothes folded after washing'**
  String get pressing_service_folding_descrip;

  /// No description provided for @pressing_service_stain_removal_descrip.
  ///
  /// In en, this message translates to:
  /// **'Stain removal'**
  String get pressing_service_stain_removal_descrip;

  /// No description provided for @pressing_service_service_express_descrip.
  ///
  /// In en, this message translates to:
  /// **'Same-day express cleaning'**
  String get pressing_service_service_express_descrip;

  /// No description provided for @pressing_service_home_laundry_descrip.
  ///
  /// In en, this message translates to:
  /// **'Sheets, blankets, curtains, etc...'**
  String get pressing_service_home_laundry_descrip;

  /// No description provided for @pressing_service_work_clothing_descrip.
  ///
  /// In en, this message translates to:
  /// **'Uniforms, Suits, Work Clothes'**
  String get pressing_service_work_clothing_descrip;

  /// No description provided for @pressing_service_delicate_fabrics_descrip.
  ///
  /// In en, this message translates to:
  /// **'Silk, Wool, Leather, Evening gowns, etc...'**
  String get pressing_service_delicate_fabrics_descrip;

  /// No description provided for @pressing_service_labelText.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get pressing_service_labelText;

  /// No description provided for @pressing_service_hinterText.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get pressing_service_hinterText;

  /// No description provided for @pressing_service_price_labelText.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get pressing_service_price_labelText;

  /// No description provided for @pressing_service_price_hinterText.
  ///
  /// In en, this message translates to:
  /// **'Product Price'**
  String get pressing_service_price_hinterText;

  /// No description provided for @pressing_service_price_min_labelText.
  ///
  /// In en, this message translates to:
  /// **'Minimum Price'**
  String get pressing_service_price_min_labelText;

  /// No description provided for @pressing_service_price_min_hinterText.
  ///
  /// In en, this message translates to:
  /// **'Minimum Product Price'**
  String get pressing_service_price_min_hinterText;

  /// No description provided for @pressing_service_price_max_labelText.
  ///
  /// In en, this message translates to:
  /// **'Maximum Price'**
  String get pressing_service_price_max_labelText;

  /// No description provided for @pressing_service_price_max_hinterText.
  ///
  /// In en, this message translates to:
  /// **'Maximum Product Price'**
  String get pressing_service_price_max_hinterText;

  /// No description provided for @pressig_details_title.
  ///
  /// In en, this message translates to:
  /// **'Dry Cleaner Details'**
  String get pressig_details_title;

  /// No description provided for @restaurant_add_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Add Restaurant'**
  String get restaurant_add_bar_title;

  /// No description provided for @restaurant_all_bar_title.
  ///
  /// In en, this message translates to:
  /// **'All Restaurants'**
  String get restaurant_all_bar_title;

  /// No description provided for @restaurant_bar_title.
  ///
  /// In en, this message translates to:
  /// **'Configuration Restaurant'**
  String get restaurant_bar_title;

  /// Add a new {storeCategory}
  ///
  /// In en, this message translates to:
  /// **'Add a {storeCategory}'**
  String store_add_bar_title(Object storeCategory);

  /// View all {storeCategory}
  ///
  /// In en, this message translates to:
  /// **'All the {storeCategory}'**
  String store_all_bar_title(Object storeCategory);

  /// Panneau de Configuration {storeCategory}
  ///
  /// In en, this message translates to:
  /// **'Configuration {storeCategory}'**
  String store_bar_title(Object storeCategory);

  /// Adress of the {storeCategory}
  ///
  /// In en, this message translates to:
  /// **'Please enter the adress of {storeCategory}'**
  String store_adress_hinter_text(Object storeCategory);

  /// Please enter a few words to describe your business
  ///
  /// In en, this message translates to:
  /// **'Please enter the description {storeCategory}'**
  String store_description_hinter_text(Object storeCategory);

  /// email of the {storeCategory}
  ///
  /// In en, this message translates to:
  /// **'Please Enter the email of the {storeCategory}'**
  String store_email_hinter_text(Object storeCategory);

  /// Name of the {storeCategory}
  ///
  /// In en, this message translates to:
  /// **'Please Enter the name of the {storeCategory}'**
  String store_name_hinter_text(Object storeCategory);

  /// Name of the {storeCategory}
  ///
  /// In en, this message translates to:
  /// **'Name of the{storeCategory}'**
  String store_name_label(Object storeCategory);

  /// Phone number of the {storeCategory}
  ///
  /// In en, this message translates to:
  /// **'Please Enter the phone number of the {storeCategory}'**
  String store_phone_hinter_text(Object storeCategory);

  /// success message
  ///
  /// In en, this message translates to:
  /// **'{storeCategory} addedd successfully'**
  String store_add_success_message(Object storeCategory);

  /// Type of {storeCategory]
  ///
  /// In en, this message translates to:
  /// **'Type {storeCategory}'**
  String store_type(Object storeCategory);

  /// No description provided for @description_title.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description_title;

  /// No description provided for @description_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Please enter the Description'**
  String get description_hint_text;

  /// Text for search Button
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_title;

  /// the adress label
  ///
  /// In en, this message translates to:
  /// **'Adress'**
  String get company_adresse_label;

  /// the phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get company_label_phone;

  /// the Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get company_label_email;

  /// No description provided for @success_send_message_title.
  ///
  /// In en, this message translates to:
  /// **'Message send'**
  String get success_send_message_title;

  /// No description provided for @success_send_message_message.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your message'**
  String get success_send_message_message;

  /// No description provided for @success_registration_new_user.
  ///
  /// In en, this message translates to:
  /// **'Your account has been successfully created'**
  String get success_registration_new_user;

  /// No description provided for @success_login_message.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get success_login_message;

  /// No description provided for @success_login_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Lien envoyé avec Succes'**
  String get success_login_reset_password;

  /// No description provided for @login_forget_password_txt.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we will send you a link to reset your password '**
  String get login_forget_password_txt;

  /// No description provided for @error_send_mail_title.
  ///
  /// In en, this message translates to:
  /// **'Authentication Error'**
  String get error_send_mail_title;

  /// No description provided for @error_send_mail_message.
  ///
  /// In en, this message translates to:
  /// **'You must sign before using this functionnality'**
  String get error_send_mail_message;

  /// No description provided for @error_input_hint_message.
  ///
  /// In en, this message translates to:
  /// **'Please write your message.'**
  String get error_input_hint_message;

  /// No description provided for @error_firebase_initialisation.
  ///
  /// In en, this message translates to:
  /// **'FirebaseAuth initialization failed:'**
  String get error_firebase_initialisation;

  /// No description provided for @error_login_message.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get error_login_message;

  /// No description provided for @error_register_title.
  ///
  /// In en, this message translates to:
  /// **'Registration Error'**
  String get error_register_title;

  /// No description provided for @error_register_with_phone_message.
  ///
  /// In en, this message translates to:
  /// **'We were unable to register your phone number. Please try again !'**
  String get error_register_with_phone_message;

  /// No description provided for @error_application.
  ///
  /// In en, this message translates to:
  /// **'We have more then one Super Admin'**
  String get error_application;

  /// No description provided for @error_register_with_email_message.
  ///
  /// In en, this message translates to:
  /// **'We were unable to register your email. Please try again !'**
  String get error_register_with_email_message;

  /// No description provided for @error_authorization.
  ///
  /// In en, this message translates to:
  /// **'Not Authorize'**
  String get error_authorization;

  /// No description provided for @error_occur.
  ///
  /// In en, this message translates to:
  /// **'An error Occured'**
  String get error_occur;

  /// No description provided for @error_send_formular.
  ///
  /// In en, this message translates to:
  /// **'Please Complete the formular '**
  String get error_send_formular;

  /// No description provided for @error_show_formular_title.
  ///
  /// In en, this message translates to:
  /// **'Error Page'**
  String get error_show_formular_title;

  /// No description provided for @error_show_formular.
  ///
  /// In en, this message translates to:
  /// **'An Error happen when loading the page'**
  String get error_show_formular;

  /// No description provided for @error_no_user_connected_title.
  ///
  /// In en, this message translates to:
  /// **'Authentication Error'**
  String get error_no_user_connected_title;

  /// No description provided for @error_no_user_connected_message.
  ///
  /// In en, this message translates to:
  /// **'No user is currently signed in.'**
  String get error_no_user_connected_message;

  /// No description provided for @label_login_facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get label_login_facebook;

  /// No description provided for @label_login_google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get label_login_google;

  /// No description provided for @btn_close_label.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get btn_close_label;

  /// No description provided for @btn_send_label.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get btn_send_label;

  /// No description provided for @btn_register_label.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get btn_register_label;

  /// No description provided for @btn_add_contact.
  ///
  /// In en, this message translates to:
  /// **'Add a Contact'**
  String get btn_add_contact;

  /// No description provided for @btn_add_pressing_service.
  ///
  /// In en, this message translates to:
  /// **'Add a Service'**
  String get btn_add_pressing_service;

  /// No description provided for @btn_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get btn_create;

  /// No description provided for @verify_otp.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get verify_otp;

  /// No description provided for @resend_code.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resend_code;

  /// No description provided for @form_contact_title.
  ///
  /// In en, this message translates to:
  /// **'Contact Form:'**
  String get form_contact_title;

  /// No description provided for @input_hint_first_name.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get input_hint_first_name;

  /// No description provided for @input_hint_last_name.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get input_hint_last_name;

  /// No description provided for @input_hint_adress_email.
  ///
  /// In en, this message translates to:
  /// **'Email Adress'**
  String get input_hint_adress_email;

  /// No description provided for @input_hint_message.
  ///
  /// In en, this message translates to:
  /// **'Your Message...'**
  String get input_hint_message;

  /// No description provided for @input_hint_adress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get input_hint_adress;

  /// No description provided for @input_hint_middle_name.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get input_hint_middle_name;

  /// No description provided for @input_hint_quartier.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get input_hint_quartier;

  /// No description provided for @input_hint_longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get input_hint_longitude;

  /// No description provided for @input_hint_latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get input_hint_latitude;

  /// No description provided for @movegui_info_title.
  ///
  /// In en, this message translates to:
  /// **'MoveGui – Motorcycle Delivery & Transport in Guinea'**
  String get movegui_info_title;

  /// No description provided for @movegui_info_text_1.
  ///
  /// In en, this message translates to:
  /// **'MoveGui is an innovative company specialising in food delivery and motorcycle transport in Guinea.Our mission is to make delivery more accessible, more transparent and more affordable for everyone.'**
  String get movegui_info_text_1;

  /// No description provided for @movegui_info_text_2.
  ///
  /// In en, this message translates to:
  /// **'We offer a fixed price for every journey, regardless of the distance, ensuring complete transparency for our customers.No more price surprises – just a fast, reliable and straightforward service..'**
  String get movegui_info_text_2;

  /// No description provided for @movegui_info_text_3.
  ///
  /// In en, this message translates to:
  /// **'Thanks to our partnerships with local restaurants, we offer low-cost deliveries whilst supporting the local economy.MoveGui is the perfect blend of technology, accessibility and efficiency.'**
  String get movegui_info_text_3;

  /// No description provided for @movegui_panel.
  ///
  /// In en, this message translates to:
  /// **'Movegui Configuration Panel'**
  String get movegui_panel;

  /// No description provided for @movegui_panel_mobile.
  ///
  /// In en, this message translates to:
  /// **'Configuration Panel'**
  String get movegui_panel_mobile;

  /// No description provided for @deactivate_button_title.
  ///
  /// In en, this message translates to:
  /// **'Service Unavailable '**
  String get deactivate_button_title;

  /// No description provided for @deactivate_button_message.
  ///
  /// In en, this message translates to:
  /// **'Service currently unavailable'**
  String get deactivate_button_message;

  /// No description provided for @deactivate_button_attach_message.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get deactivate_button_attach_message;

  /// No description provided for @activate_button_attach_message.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get activate_button_attach_message;

  /// No description provided for @module_courses_name.
  ///
  /// In en, this message translates to:
  /// **'Races'**
  String get module_courses_name;

  /// No description provided for @module_restaurant_name.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get module_restaurant_name;

  /// No description provided for @module_patisserie_name.
  ///
  /// In en, this message translates to:
  /// **'Pastry shop'**
  String get module_patisserie_name;

  /// No description provided for @module_supermarche_name.
  ///
  /// In en, this message translates to:
  /// **'Super Market'**
  String get module_supermarche_name;

  /// No description provided for @module_supplier_name.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get module_supplier_name;

  /// No description provided for @module_pressing_name.
  ///
  /// In en, this message translates to:
  /// **'Dry cleaning'**
  String get module_pressing_name;

  /// No description provided for @module_discovery_name.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get module_discovery_name;

  /// No description provided for @module_boulangerie_name.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get module_boulangerie_name;

  /// No description provided for @module_pharmacy_name.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get module_pharmacy_name;

  /// No description provided for @module_beauty_name.
  ///
  /// In en, this message translates to:
  /// **'Beauty & Care'**
  String get module_beauty_name;

  /// No description provided for @module_store_name.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get module_store_name;

  /// No description provided for @module_shop_name.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get module_shop_name;

  /// No description provided for @module_wholesaler_name.
  ///
  /// In en, this message translates to:
  /// **'Wholesaler'**
  String get module_wholesaler_name;

  /// No description provided for @module_profession_name.
  ///
  /// In en, this message translates to:
  /// **'Professions'**
  String get module_profession_name;

  /// No description provided for @module_fast_food_name.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get module_fast_food_name;

  /// No description provided for @module_category_name.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get module_category_name;

  /// No description provided for @module_ingredient_name.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get module_ingredient_name;

  /// No description provided for @module_pastry_name.
  ///
  /// In en, this message translates to:
  /// **'Pastry'**
  String get module_pastry_name;

  /// No description provided for @module_product_name.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get module_product_name;

  /// No description provided for @module_recipe_name.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get module_recipe_name;

  /// No description provided for @module_super_market_name.
  ///
  /// In en, this message translates to:
  /// **'Super Market'**
  String get module_super_market_name;

  /// No description provided for @module_admin_name.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get module_admin_name;

  /// No description provided for @module_employe_name.
  ///
  /// In en, this message translates to:
  /// **'Employe'**
  String get module_employe_name;

  /// No description provided for @module_manager_name.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get module_manager_name;

  /// No description provided for @module_deliver_name.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get module_deliver_name;

  /// No description provided for @tooltip_add.
  ///
  /// In en, this message translates to:
  /// **'Clic here to Add '**
  String get tooltip_add;

  /// No description provided for @tooltip_all.
  ///
  /// In en, this message translates to:
  /// **'Clic here to see All'**
  String get tooltip_all;

  /// No description provided for @notification_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification_title;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_title;

  /// No description provided for @movegui_title.
  ///
  /// In en, this message translates to:
  /// **'Movegui'**
  String get movegui_title;

  /// No description provided for @command_title.
  ///
  /// In en, this message translates to:
  /// **'Command'**
  String get command_title;

  /// No description provided for @delivery_title.
  ///
  /// In en, this message translates to:
  /// **'Delivey'**
  String get delivery_title;

  /// No description provided for @courier_title.
  ///
  /// In en, this message translates to:
  /// **'Courier'**
  String get courier_title;

  /// No description provided for @my_orders_title.
  ///
  /// In en, this message translates to:
  /// **'Mes Commandes'**
  String get my_orders_title;

  /// No description provided for @my_deliveries_title.
  ///
  /// In en, this message translates to:
  /// **'Mes Livraisons'**
  String get my_deliveries_title;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @navigation_menu_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Navigation Menu'**
  String get navigation_menu_tooltip;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_title;

  /// No description provided for @register_title.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get register_title;

  /// No description provided for @forget_password_title.
  ///
  /// In en, this message translates to:
  /// **'Forgetten Password'**
  String get forget_password_title;

  /// No description provided for @dashbord_title.
  ///
  /// In en, this message translates to:
  /// **'Panneau de Configuration'**
  String get dashbord_title;

  /// No description provided for @register_admin_title.
  ///
  /// In en, this message translates to:
  /// **'Admin Registration'**
  String get register_admin_title;

  /// No description provided for @register_employe_title.
  ///
  /// In en, this message translates to:
  /// **'Employee Registration'**
  String get register_employe_title;

  /// No description provided for @register_manager_title.
  ///
  /// In en, this message translates to:
  /// **'Manager Registration'**
  String get register_manager_title;

  /// No description provided for @register_driver_title.
  ///
  /// In en, this message translates to:
  /// **'Deliver Registration'**
  String get register_driver_title;

  /// No description provided for @address_office_title.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get address_office_title;

  /// No description provided for @address_neighbor_title.
  ///
  /// In en, this message translates to:
  /// **'Neighbord'**
  String get address_neighbor_title;

  /// No description provided for @address_home_title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get address_home_title;

  /// No description provided for @address_other_title.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get address_other_title;

  /// No description provided for @label_login_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forgotten your password?'**
  String get label_login_forget_password;

  /// No description provided for @label_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get label_login;

  /// No description provided for @label_login_connect_using.
  ///
  /// In en, this message translates to:
  /// **'Or connect using'**
  String get label_login_connect_using;

  /// No description provided for @label_login_invite.
  ///
  /// In en, this message translates to:
  /// **'Invité ?'**
  String get label_login_invite;

  /// No description provided for @label_login_new_user.
  ///
  /// In en, this message translates to:
  /// **'Nouveau ?'**
  String get label_login_new_user;

  /// No description provided for @label_registration.
  ///
  /// In en, this message translates to:
  /// **'Sign-up'**
  String get label_registration;

  /// No description provided for @label_enter_your_code.
  ///
  /// In en, this message translates to:
  /// **'Enter your Code:'**
  String get label_enter_your_code;

  /// No description provided for @label_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get label_name;

  /// No description provided for @lable_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get lable_username;

  /// No description provided for @label_adress.
  ///
  /// In en, this message translates to:
  /// **'Adress'**
  String get label_adress;

  /// No description provided for @label_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get label_email;

  /// No description provided for @label_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get label_phone;

  /// No description provided for @label_role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get label_role;

  /// No description provided for @label_firstname.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get label_firstname;

  /// No description provided for @label_lastname.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get label_lastname;

  /// No description provided for @label_district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get label_district;

  /// No description provided for @label_municipality.
  ///
  /// In en, this message translates to:
  /// **'Municipality'**
  String get label_municipality;

  /// No description provided for @exception_login_message.
  ///
  /// In en, this message translates to:
  /// **'The Supplied User credential is incorrect, Please check your email address and password'**
  String get exception_login_message;

  /// No description provided for @tooltip_sign_in_with_google.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get tooltip_sign_in_with_google;

  /// No description provided for @tooltip_sign_in_with_facebook.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Facebook'**
  String get tooltip_sign_in_with_facebook;

  /// No description provided for @tooltip_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Clic here to Connect'**
  String get tooltip_sign_in;

  /// No description provided for @tooltip_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Click here to reset password :)'**
  String get tooltip_forget_password;

  /// No description provided for @tooltip_registration.
  ///
  /// In en, this message translates to:
  /// **'Cliquez ici pour vous enregistrer :)'**
  String get tooltip_registration;

  /// No description provided for @tooltip_btn_send.
  ///
  /// In en, this message translates to:
  /// **'Click here to submit your code'**
  String get tooltip_btn_send;

  /// No description provided for @tooltip_btn_add_contact.
  ///
  /// In en, this message translates to:
  /// **'Add a new Contact'**
  String get tooltip_btn_add_contact;

  /// No description provided for @tooltip_btn_add_pressing_service.
  ///
  /// In en, this message translates to:
  /// **'Ajouter new Service'**
  String get tooltip_btn_add_pressing_service;

  /// No description provided for @profile_menu_invite_people.
  ///
  /// In en, this message translates to:
  /// **'Invite a Friend'**
  String get profile_menu_invite_people;

  /// No description provided for @profile_menu_orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get profile_menu_orders;

  /// No description provided for @profile_menu_message.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get profile_menu_message;

  /// No description provided for @profile_menu_important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get profile_menu_important;

  /// No description provided for @profile_menu_devices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get profile_menu_devices;

  /// No description provided for @profile_menu_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profile_menu_account;

  /// No description provided for @profile_menu_confidentiality.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get profile_menu_confidentiality;

  /// No description provided for @profile_menu_discussions.
  ///
  /// In en, this message translates to:
  /// **'Discussions'**
  String get profile_menu_discussions;

  /// No description provided for @profile_menu_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profile_menu_delete_account;

  /// No description provided for @profile_menu_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_menu_logout;

  /// No description provided for @profile_menu_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get profile_menu_login;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Ajouter'**
  String get add;

  /// No description provided for @add_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get add_all;

  /// No description provided for @menu_main.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get menu_main;

  /// No description provided for @menu_store_type.
  ///
  /// In en, this message translates to:
  /// **'Store Types'**
  String get menu_store_type;

  /// No description provided for @menu_store_categories.
  ///
  /// In en, this message translates to:
  /// **'Store Categories'**
  String get menu_store_categories;

  /// No description provided for @menu_restaurant_type.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Type'**
  String get menu_restaurant_type;

  /// No description provided for @menu_menu.
  ///
  /// In en, this message translates to:
  /// **'Menus'**
  String get menu_menu;

  /// No description provided for @day_lundi.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get day_lundi;

  /// No description provided for @day_mardi.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get day_mardi;

  /// No description provided for @day_mercredi.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get day_mercredi;

  /// No description provided for @day_jeudi.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get day_jeudi;

  /// No description provided for @day_vendredi.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get day_vendredi;

  /// No description provided for @day_samedi.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get day_samedi;

  /// No description provided for @day_dimanche.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get day_dimanche;

  /// No description provided for @last_orders.
  ///
  /// In en, this message translates to:
  /// **'Last Orders'**
  String get last_orders;

  /// No description provided for @message_movegui_title.
  ///
  /// In en, this message translates to:
  /// **'<p>Welcome on Movegui</p>'**
  String get message_movegui_title;

  /// No description provided for @message_movegui_link.
  ///
  /// In en, this message translates to:
  /// **'Create a Password'**
  String get message_movegui_link;

  /// No description provided for @message_movegui.
  ///
  /// In en, this message translates to:
  /// **'Tahnks for trusting the MoveGui Team'**
  String get message_movegui;

  /// No description provided for @dashbord_movegui_title.
  ///
  /// In en, this message translates to:
  /// **'Dashboard MoveGui'**
  String get dashbord_movegui_title;

  /// No description provided for @dashbord_movegui_sub_title.
  ///
  /// In en, this message translates to:
  /// **'Overview of orders, revenue and users'**
  String get dashbord_movegui_sub_title;

  /// No description provided for @dashbord_orders_state_title.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get dashbord_orders_state_title;

  /// No description provided for @dashbord_orders_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get dashbord_orders_pending;

  /// No description provided for @dashbord_orders_preparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get dashbord_orders_preparing;

  /// No description provided for @dashbord_orders_delivering.
  ///
  /// In en, this message translates to:
  /// **'Delivering'**
  String get dashbord_orders_delivering;

  /// No description provided for @dashbord_orders_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get dashbord_orders_completed;

  /// No description provided for @dashbord_orders_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get dashbord_orders_cancelled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
