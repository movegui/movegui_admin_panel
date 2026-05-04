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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// Text for search Button
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

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

  /// No description provided for @error_register_with_phone_title.
  ///
  /// In en, this message translates to:
  /// **'Registration Error'**
  String get error_register_with_phone_title;

  /// No description provided for @error_register_with_phone_message.
  ///
  /// In en, this message translates to:
  /// **'We were unable to register your phone number. Please try again !'**
  String get error_register_with_phone_message;

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

  /// No description provided for @category_courses_name.
  ///
  /// In en, this message translates to:
  /// **'Races'**
  String get category_courses_name;

  /// No description provided for @category_restaurant_name.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get category_restaurant_name;

  /// No description provided for @category_patisserie_name.
  ///
  /// In en, this message translates to:
  /// **'Pastry shop'**
  String get category_patisserie_name;

  /// No description provided for @category_supermarche_name.
  ///
  /// In en, this message translates to:
  /// **'Super Market'**
  String get category_supermarche_name;

  /// No description provided for @category_supplier_name.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get category_supplier_name;

  /// No description provided for @category_pressing_name.
  ///
  /// In en, this message translates to:
  /// **'Dry cleaning'**
  String get category_pressing_name;

  /// No description provided for @category_discovery_name.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get category_discovery_name;

  /// No description provided for @category_boulangerie_name.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get category_boulangerie_name;

  /// No description provided for @category_pharmacy_name.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get category_pharmacy_name;

  /// No description provided for @category_beauty_name.
  ///
  /// In en, this message translates to:
  /// **'Beauty & Care'**
  String get category_beauty_name;

  /// No description provided for @categroy_store_name.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get categroy_store_name;

  /// No description provided for @category_shop_name.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get category_shop_name;

  /// No description provided for @category_wholesaler_name.
  ///
  /// In en, this message translates to:
  /// **'Wholesaler'**
  String get category_wholesaler_name;

  /// No description provided for @category_profession_name.
  ///
  /// In en, this message translates to:
  /// **'Professions'**
  String get category_profession_name;

  /// No description provided for @category_fast_food_name.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get category_fast_food_name;

  /// No description provided for @category_category_name.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category_category_name;

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

  /// No description provided for @pressing_title.
  ///
  /// In en, this message translates to:
  /// **'Dry Cleaning'**
  String get pressing_title;

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

  /// No description provided for @profile_menu_notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profile_menu_notification;

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

  /// No description provided for @menu_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get menu_categories;

  /// No description provided for @menu_supplier.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get menu_supplier;

  /// No description provided for @menu_ingredient.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get menu_ingredient;

  /// No description provided for @menu_recipe.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get menu_recipe;

  /// No description provided for @menu_product.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get menu_product;

  /// No description provided for @menu_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get menu_restaurant;

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

  /// No description provided for @menu_pastry.
  ///
  /// In en, this message translates to:
  /// **'Pastry'**
  String get menu_pastry;

  /// No description provided for @menu_super_market.
  ///
  /// In en, this message translates to:
  /// **'Super Market'**
  String get menu_super_market;

  /// No description provided for @menu_pressing.
  ///
  /// In en, this message translates to:
  /// **'Dry Cleaner'**
  String get menu_pressing;

  /// No description provided for @menu_professionel.
  ///
  /// In en, this message translates to:
  /// **'Professionnel'**
  String get menu_professionel;

  /// No description provided for @menu_menu.
  ///
  /// In en, this message translates to:
  /// **'Menus'**
  String get menu_menu;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
