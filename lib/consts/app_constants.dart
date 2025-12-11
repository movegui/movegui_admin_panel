



import '../services/assets_manager.dart';

class AppConstants {
  static const String imageUrl = 'https://i.ibb.co/JM0KMG0/riz-gras.jpg';
    //  'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2
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


}

abstract class StoreConstants{

  String getNameLabelText();
  String getNameHinterText();
  String getDescripLabelText();
  String getDescripHinterText();
  String getAdressLabeltext();
  String getAdressHinterText();
  String getEmailLabelText();
  String getEmailHinterText();
  String getPhoneLabelText();
  String getPhoneHinterText();
  String getSaveSuccessText();
  String getTypeStoreText();
  String getMenuTitleText();
   
       String getImageSelectionErrorText() {
          return 'Veuillez choisir une Image svp !!';
       }
     
     
       String getImageSelectionText() {
         return 'Une Erreur s\'est produite';
       }
}

class RestaurantConstants extends StoreConstants {

     @override
     String getAdressHinterText() {
      return 'Veuillez saisir l\'adresse du Restaurant';
     }
   
     @override
     String getAdressLabeltext() {
      return 'Adresse';
     } 
   
     @override
     String getDescripHinterText() {
      return 'Veuillez saisir la description du Restaurant';
     }
   
     @override
     String getDescripLabelText() {
      return 'Description';
     } 
   
     @override
     String getEmailHinterText() {
      return 'Veuillez saisir l\'email du Restaurant';
     }
   
     @override
     String getEmailLabelText() {
       return 'Email';
     }
   
     @override
     String getNameHinterText() {
      return 'Veuillez saisir le nom du Restaurant';
     }
   
     @override
     String getNameLabelText() {
      return 'Nom du Restaurant';
     }
   
     @override
     String getPhoneHinterText() {
      return 'Veuillez saisir le téléphone du Restaurant';
     }
   
     @override
     String getPhoneLabelText() {
      return 'Téléphone';
     }
     
       @override
       String getSaveSuccessText() {
         return 'Restaurant ajouté avec succes !!!';
       }
       
         @override
         String getTypeStoreText() {
           return 'Types Restaurants';
         }
         
           @override
           String getMenuTitleText() {
             return 'Ajouter un Restaurant';
           }

}

class ProfessionConstants extends StoreConstants {

     @override
     String getAdressHinterText() {
      return 'Veuillez saisir l\'adresse de la Profession';
     }
   
     @override
     String getAdressLabeltext() {
      return 'Adresse';
     } 
   
     @override
     String getDescripHinterText() {
      return 'Veuillez saisir la description de la Profession';
     }
   
     @override
     String getDescripLabelText() {
      return 'Description';
     } 
   
     @override
     String getEmailHinterText() {
      return 'Veuillez saisir l\'email de la Profession';
     }
   
     @override
     String getEmailLabelText() {
       return 'Email';
     }
   
     @override
     String getNameHinterText() {
      return 'Veuillez saisir le nom de la Profession';
     }
   
     @override
     String getNameLabelText() {
      return 'Nom de la Profession';
     }
   
     @override
     String getPhoneHinterText() {
      return 'Veuillez saisir le téléphone de la Profession';
     }
   
     @override
     String getPhoneLabelText() {
      return 'Téléphone';
     }
     
       @override
       String getSaveSuccessText() {
         return 'Profession ajouée avec succes';
       }
       
         @override
         String getTypeStoreText() {
           return 'Types Professions';
         }
              
           @override
           String getMenuTitleText() {
             return 'Ajouter une Profession';
           }

}

class PatisserieConstants extends StoreConstants {

     @override
     String getAdressHinterText() {
      return 'Veuillez saisir l\'adresse de la Patisserie';
     }
   
     @override
     String getAdressLabeltext() {
      return 'Adresse';
     } 
   
     @override
     String getDescripHinterText() {
      return 'Veuillez saisir la description de la Patisserie';
     }
   
     @override
     String getDescripLabelText() {
      return 'Description';
     } 
   
     @override
     String getEmailHinterText() {
      return 'Veuillez saisir l\'email de la Patisserie';
     }
   
     @override
     String getEmailLabelText() {
       return 'Email';
     }
   
     @override
     String getNameHinterText() {
      return 'Veuillez saisir le nom de la Patisserie';
     }
   
     @override
     String getNameLabelText() {
      return 'Nom de la Patisserie';
     }
   
     @override
     String getPhoneHinterText() {
      return 'Veuillez saisir le téléphone de la Patisserie';
     }
   
     @override
     String getPhoneLabelText() {
      return 'Téléphone';
     }
     
       @override
       String getSaveSuccessText() {
         return 'Patisserie ajouée avec succes !!';
       }
       
         @override
         String getTypeStoreText() {
           return 'Types Patisserie';
         }

              
           @override
           String getMenuTitleText() {
             return 'Ajouter une Patisserie';
           }
}

class PressingConstants extends StoreConstants {

     @override
     String getAdressHinterText() {
      return 'Veuillez saisir l\'adresse du Pressing';
     }
   
     @override
     String getAdressLabeltext() {
      return 'Adresse';
     } 
   
     @override
     String getDescripHinterText() {
      return 'Veuillez saisir la description du Pressing';
     }
   
     @override
     String getDescripLabelText() {
      return 'Description';
     } 
   
     @override
     String getEmailHinterText() {
      return 'Veuillez saisir l\'email du Pressing';
     }
   
     @override
     String getEmailLabelText() {
       return 'Email';
     }
   
     @override
     String getNameHinterText() {
      return 'Veuillez saisir le nom du Pressing';
     }
   
     @override
     String getNameLabelText() {
      return 'Nom du Pressing';
     }
   
     @override
     String getPhoneHinterText() {
      return 'Veuillez saisir le téléphone du Pressing';
     }
   
     @override
     String getPhoneLabelText() {
      return 'Téléphone';
     }
     
       @override
       String getSaveSuccessText() {
         return 'Pressing ajouté avec succes !!';
       }
       
         @override
         String getTypeStoreText() {
           return 'Types Patisserie';
         }

              
           @override
           String getMenuTitleText() {
             return 'Ajouter un Pressing';
           }
}

class SuperMarktConstants extends StoreConstants {

     @override
     String getAdressHinterText() {
      return 'Veuillez saisir l\'adresse du Super Marché';
     }
   
     @override
     String getAdressLabeltext() {
      return 'Adresse';
     } 
   
     @override
     String getDescripHinterText() {
      return 'Veuillez saisir la descriptionde du Super Marché';
     }
   
     @override
     String getDescripLabelText() {
      return 'Description';
     } 
   
     @override
     String getEmailHinterText() {
      return 'Veuillez saisir l\'email du Super Marché';
     }
   
     @override
     String getEmailLabelText() {
       return 'Email';
     }
   
     @override
     String getNameHinterText() {
      return 'Veuillez saisir le nom du Super Marché';
     }
   
     @override
     String getNameLabelText() {
      return 'Nom du Super Marché';
     }
   
     @override
     String getPhoneHinterText() {
      return 'Veuillez saisir le téléphone du Super Marché';
     }
   
     @override
     String getPhoneLabelText() {
      return 'Téléphone';
     }
     
       @override
       String getSaveSuccessText() {
         return 'Super Marché ajouté avec succes !!';
       }
       
         @override
         String getTypeStoreText() {
           return 'Types Supers Marches';
         }

              
           @override
           String getMenuTitleText() {
             return 'Ajouter un Super Marché';
           }
}

class SupplierConstants extends StoreConstants {

     @override
     String getAdressHinterText() {
      return 'Veuillez saisir l\'adresse du Fournisseur';
     }
   
     @override
     String getAdressLabeltext() {
      return 'Adresse';
     } 
   
     @override
     String getDescripHinterText() {
      return 'Veuillez saisir la descriptionde du Fournisseur';
     }
   
     @override
     String getDescripLabelText() {
      return 'Description';
     } 
   
     @override
     String getEmailHinterText() {
      return 'Veuillez saisir l\'email du Fournisseur';
     }
   
     @override
     String getEmailLabelText() {
       return 'Email';
     }
   
     @override
     String getNameHinterText() {
      return 'Veuillez saisir le nom du Fournisseur';
     }
   
     @override
     String getNameLabelText() {
      return 'Nom du Fournisseur';
     }
   
     @override
     String getPhoneHinterText() {
      return 'Veuillez saisir le téléphone du Fournisseur';
     }
   
     @override
     String getPhoneLabelText() {
      return 'Téléphone';
     }
     
       @override
       String getSaveSuccessText() {
         return 'Fournisseur ajoutée avec succes !!';
       }
       
         @override
         String getTypeStoreText() {
           return 'Types Fournisseurs';
         }

              
           @override
           String getMenuTitleText() {
             return 'Ajouter un Fournisseur';
           }
}

abstract class CategoriesConstants{
  String getTitle();
  String getLabelText();
  String getHinterText();
  String getNaameValidatorText();
  String getSaveSuccessText();
}

class StoreCategoriesConstants extends CategoriesConstants{
   
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
  }}

