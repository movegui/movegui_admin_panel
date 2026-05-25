import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';

import '../services/assets_manager.dart';

class AppConstants {
  static const String imageUrl = 'https://i.ibb.co/JM0KMG0/riz-gras.jpg';
  //  'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  // [url=https://ibb.co/JM0KMG0][img]https://i.ibb.co/JM0KMG0/riz-gras.jpg[/img][/url]

  static List<String> daysOfWeek = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samdei",
    "Dimanche",
  ];

  static List<PressingServiceTypeModel> getPressingServices(
    BuildContext context,
  )  {
    return [
      PressingServiceTypeModel(
        id: '001',
        name: AppLocalizations.of(context)!.pressing_service_delicate_fabrics,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_delicate_fabrics_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '002',
        name: AppLocalizations.of(context)!.pressing_service_folding,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_folding_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '003',
        name: AppLocalizations.of(context)!.pressing_service_dry_cleaning,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_dry_cleaning_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '004',
        name: AppLocalizations.of(context)!.pressing_service_home_laundry,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_home_laundry_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '005',
        name: AppLocalizations.of(context)!.pressing_service_ironing,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_ironing_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '006',
        name: AppLocalizations.of(context)!.pressing_service_laundry,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_laundry_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '007',
        name: AppLocalizations.of(context)!.pressing_service_service_express,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_service_express_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '008',
        name: AppLocalizations.of(context)!.pressing_service_stain_removal,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_stain_removal_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '009',
        name: AppLocalizations.of(context)!.pressing_service_washing,
        description: AppLocalizations.of(
          context,
        )!.pressing_service_washing_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
      PressingServiceTypeModel(
        id: '010',
        name: AppLocalizations.of(context)!.pressing_service_washing,
        description: AppLocalizations.of(

          context,
        )!.pressing_service_washing_descrip,
        pricingType: PricingType.fixed.name,
        createdAt: DateTime.now(),
      ),
    ];
  }
}

abstract class StoreConstants extends ImageConstatnt {
  String getNameLabelText(BuildContext context);
  String getNameHinterText(BuildContext context);
  String getDescripLabelText(BuildContext context);
  String getDescripHinterText(BuildContext context);
  String getAdressLabeltext(BuildContext context);
  String getAdressHinterText(BuildContext context);
  String getEmailLabelText(BuildContext context);
  String getEmailHinterText(BuildContext context);
  String getPhoneLabelText(BuildContext context);
  String getPhoneHinterText(BuildContext context);
  String getSaveSuccessText(BuildContext context);
  String getTypeStoreText(BuildContext context);
  String getMenuTitleText(BuildContext context);
  String getStoreCategory(BuildContext context);
}

class ImageConstatnt {
  String getImageSelectionErrorText() {
    return 'Veuillez choisir une Image svp !!';
  }

  String getImageSelectionText() {
    return 'Une Erreur s\'est produite';
  }
}

class RestaurantConstants extends StoreConstants {
  @override
  String getAdressHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_adress_hinter_text(getStoreCategory(context));
  }

  @override
  String getAdressLabeltext(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress;
  }

  @override
  String getDescripHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_description_hinter_text(getStoreCategory(context));
  }

  @override
  String getDescripLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.description_title;
  }

  @override
  String getEmailHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_email_hinter_text(getStoreCategory(context));
  }

  @override
  String getEmailLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress_email;
  }

  @override
  String getNameHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_name_hinter_text(getStoreCategory(context));
  }

  @override
  String getNameLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.category_restaurant_name;
  }

  @override
  String getPhoneHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_phone_hinter_text(getStoreCategory(context));
  }

  @override
  String getPhoneLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.label_phone;
  }

  @override
  String getSaveSuccessText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_add_success_message(getStoreCategory(context));
  }

  @override
  String getTypeStoreText(BuildContext context) {
    return AppLocalizations.of(context)!.store_type(getStoreCategory(context));
  }

  @override
  String getMenuTitleText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_bar_title(getStoreCategory(context));
  }

  @override
  String getStoreCategory(BuildContext context) {
    return AppLocalizations.of(context)!.category_restaurant_name;
  }
}

class ProfessionConstants extends StoreConstants {
  @override
  String getAdressHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_adress_hinter_text(getStoreCategory(context));
  }

  @override
  String getAdressLabeltext(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress;
  }

  @override
  String getDescripHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_description_hinter_text(getStoreCategory(context));
  }

  @override
  String getDescripLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.description_title;
  }

  @override
  String getEmailHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_email_hinter_text(getStoreCategory(context));
  }

  @override
  String getEmailLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress_email;
  }

  @override
  String getNameHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_name_hinter_text(getStoreCategory(context));
  }

  @override
  String getNameLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.category_profession_name;
  }

  @override
  String getPhoneHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_phone_hinter_text(getStoreCategory(context));
  }

  @override
  String getPhoneLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.label_phone;
  }

  @override
  String getSaveSuccessText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_add_success_message(getStoreCategory(context));
  }

  @override
  String getTypeStoreText(BuildContext context) {
    return AppLocalizations.of(context)!.store_type(getStoreCategory(context));
  }

  @override
  String getMenuTitleText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_bar_title(getStoreCategory(context));
  }

  @override
  String getStoreCategory(BuildContext context) {
    return AppLocalizations.of(context)!.category_profession_name;
  }
}

class PatisserieConstants extends StoreConstants {
  @override
  String getAdressHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_adress_hinter_text(getStoreCategory(context));
  }

  @override
  String getAdressLabeltext(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress;
  }

  @override
  String getDescripHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_description_hinter_text(getStoreCategory(context));
  }

  @override
  String getDescripLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.description_title;
  }

  @override
  String getEmailHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_email_hinter_text(getStoreCategory(context));
  }

  @override
  String getEmailLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress_email;
  }

  @override
  String getNameHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_name_hinter_text(getStoreCategory(context));
  }

  @override
  String getNameLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.category_pastry_name;
  }

  @override
  String getPhoneHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_phone_hinter_text(getStoreCategory(context));
  }

  @override
  String getPhoneLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.label_phone;
  }

  @override
  String getSaveSuccessText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_add_success_message(getStoreCategory(context));
  }

  @override
  String getTypeStoreText(BuildContext context) {
    return AppLocalizations.of(context)!.store_type(getStoreCategory(context));
  }

  @override
  String getMenuTitleText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_bar_title(getStoreCategory(context));
  }

  @override
  String getStoreCategory(BuildContext context) {
    return AppLocalizations.of(context)!.category_pastry_name;
  }
}

class PressingConstants extends StoreConstants {
  @override
  String getAdressHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_adress_hinter_text(getStoreCategory(context));
  }

  @override
  String getAdressLabeltext(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress;
  }

  @override
  String getDescripHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_description_hinter_text(getStoreCategory(context));
  }

  @override
  String getDescripLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.description_title;
  }

  @override
  String getEmailHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_email_hinter_text(getStoreCategory(context));
  }

  @override
  String getEmailLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress_email;
  }

  @override
  String getNameHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_name_hinter_text(getStoreCategory(context));
  }

  @override
  String getNameLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.category_pressing_name;
  }

  @override
  String getPhoneHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_phone_hinter_text(getStoreCategory(context));
  }

  @override
  String getPhoneLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.label_phone;
  }

  @override
  String getSaveSuccessText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_add_success_message(getStoreCategory(context));
  }

  @override
  String getTypeStoreText(BuildContext context) {
    return AppLocalizations.of(context)!.store_type(getStoreCategory(context));
  }

  @override
  String getMenuTitleText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_bar_title(getStoreCategory(context));
  }

  @override
  String getStoreCategory(BuildContext context) {
    return AppLocalizations.of(context)!.category_pressing_name;
  }
}

class SuperMarktConstants extends StoreConstants {
  @override
  String getAdressHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_adress_hinter_text(getStoreCategory(context));
  }

  @override
  String getAdressLabeltext(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress;
  }

  @override
  String getDescripHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_description_hinter_text(getStoreCategory(context));
  }

  @override
  String getDescripLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.description_title;
  }

  @override
  String getEmailHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_email_hinter_text(getStoreCategory(context));
  }

  @override
  String getEmailLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress_email;
  }

  @override
  String getNameHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_name_hinter_text(getStoreCategory(context));
  }

  @override
  String getNameLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.category_super_market_name;
  }

  @override
  String getPhoneHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_phone_hinter_text(getStoreCategory(context));
  }

  @override
  String getPhoneLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.label_phone;
  }

  @override
  String getSaveSuccessText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_add_success_message(getStoreCategory(context));
  }

  @override
  String getTypeStoreText(BuildContext context) {
    return AppLocalizations.of(context)!.store_type(getStoreCategory(context));
  }

  @override
  String getMenuTitleText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_bar_title(getStoreCategory(context));
  }

  @override
  String getStoreCategory(BuildContext context) {
    return AppLocalizations.of(context)!.category_super_market_name;
  }
}

class SupplierConstants extends StoreConstants {
  @override
  String getAdressHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_adress_hinter_text(getStoreCategory(context));
  }

  @override
  String getAdressLabeltext(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress;
  }

  @override
  String getDescripHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_description_hinter_text(getStoreCategory(context));
  }

  @override
  String getDescripLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.description_title;
  }

  @override
  String getEmailHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_email_hinter_text(getStoreCategory(context));
  }

  @override
  String getEmailLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.input_hint_adress_email;
  }

  @override
  String getNameHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_name_hinter_text(getStoreCategory(context));
  }

  @override
  String getNameLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.category_supplier_name;
  }

  @override
  String getPhoneHinterText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_phone_hinter_text(getStoreCategory(context));
  }

  @override
  String getPhoneLabelText(BuildContext context) {
    return AppLocalizations.of(context)!.label_phone;
  }

  @override
  String getSaveSuccessText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_add_success_message(getStoreCategory(context));
  }

  @override
  String getTypeStoreText(BuildContext context) {
    return AppLocalizations.of(context)!.store_type(getStoreCategory(context));
  }

  @override
  String getMenuTitleText(BuildContext context) {
    return AppLocalizations.of(
      context,
    )!.store_bar_title(getStoreCategory(context));
  }

  @override
  String getStoreCategory(BuildContext context) {
    return AppLocalizations.of(context)!.category_supplier_name;
  }
}

abstract class CategoriesConstants {
  String getTitle();
  String getLabelText();
  String getHinterText();
  String getNaameValidatorText();
  String getSaveSuccessText();
}

class StoreCategoriesConstants extends CategoriesConstants {
  @override
  String getTitle() {
    return "Ajouter Une Category de Store";
  }

  @override
  String getHinterText() {
    return "Veuillez saisir le nom de la Categorie de Store";
  }

  @override
  String getLabelText() {
    return "Nom de la Categorie de Store";
  }

  @override
  String getNaameValidatorText() {
    return 'Le Nom est Obligatoire';
  }

  @override
  String getSaveSuccessText() {
    return "Novelle Categorie Ajouter avec succes!";
  }
}
