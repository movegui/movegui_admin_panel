// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get commune_title => 'Commune';

  @override
  String get gender_masculin => 'Homme';

  @override
  String get gender_female => 'Femme';

  @override
  String get open_hours_title => 'Heures d\'ouverture';

  @override
  String get store_services_title => 'Services';

  @override
  String get is_loding_text => 'Chargement...';

  @override
  String get admin_bar_title => 'Configuration Admin';

  @override
  String get admin_add_bar_title => 'Ajouter Admin';

  @override
  String get admin_all_bar_title => 'Tous les Admins';

  @override
  String get employe_bar_title => 'Configuration Employé';

  @override
  String get employe_add_bar_title => 'Ajouter Employé';

  @override
  String get employe_all_bar_title => 'Tous les Employés';

  @override
  String get employe_status_actf => 'Actif';

  @override
  String get employe_status_non_actf => 'Inactif';

  @override
  String get pressing_add_bar_title => 'Ajouter un Pressing';

  @override
  String get pressing_all_bar_title => 'Tous les Pressings';

  @override
  String get pressing_bar_title => 'Configuration Pressing';

  @override
  String get pressing_service_washing => 'Lavage';

  @override
  String get pressing_service_dry_cleaning => 'Nettoyage à sec';

  @override
  String get pressing_service_ironing => 'Repassage';

  @override
  String get pressing_service_laundry => 'Blanchisserie';

  @override
  String get pressing_service_folding => 'Pliage';

  @override
  String get pressing_service_stain_removal => 'Détachage';

  @override
  String get pressing_service_service_express => 'Service express';

  @override
  String get pressing_service_home_laundry => 'Nettoyage du linge de maison';

  @override
  String get pressing_service_work_clothing =>
      'Entretien des vêtements professionnels';

  @override
  String get pressing_service_delicate_fabrics =>
      'Traitement des textiles délicats';

  @override
  String get pressing_service_washing_descrip =>
      'Nettoyage des vêtements à l’eau';

  @override
  String get pressing_service_dry_cleaning_descrip =>
      'Nettoyage spécial pour tissus délicats';

  @override
  String get pressing_service_ironing_descrip =>
      ' Enlever les plis avec un fer ou une presse';

  @override
  String get pressing_service_laundry_descrip =>
      'Service complet de lavage et séchage';

  @override
  String get pressing_service_folding_descrip =>
      ' Vêtements pliés après lavage';

  @override
  String get pressing_service_stain_removal_descrip => 'Enlèvement des taches';

  @override
  String get pressing_service_service_express_descrip =>
      'Nettoyage rapide le jour même';

  @override
  String get pressing_service_home_laundry_descrip =>
      'Draps, Couvertures, Rideaux, etc...';

  @override
  String get pressing_service_work_clothing_descrip =>
      'Uniformes, Costumes, Vêtements de travail';

  @override
  String get pressing_service_delicate_fabrics_descrip =>
      'Soie, Laine, Cuir, Robes de soirée, etc...';

  @override
  String get pressing_service_labelText => 'Produit';

  @override
  String get pressing_service_hinterText => 'Nom du Produit';

  @override
  String get pressing_service_price_labelText => 'Prix';

  @override
  String get pressing_service_price_hinterText => 'Prix du produit';

  @override
  String get pressing_service_price_min_labelText => 'Prix Minimum';

  @override
  String get pressing_service_price_min_hinterText => 'Prix Minimum du produit';

  @override
  String get pressing_service_price_max_labelText => 'Prix Maximum';

  @override
  String get pressing_service_price_max_hinterText => 'Prix Maximum du produit';

  @override
  String get pressig_details_title => 'Details Pressing';

  @override
  String get restaurant_add_bar_title => 'Ajouter un Restaurant';

  @override
  String get restaurant_all_bar_title => 'Tous les Restaurant';

  @override
  String get restaurant_bar_title => 'Configuration Restaurant';

  @override
  String store_add_bar_title(Object storeCategory) {
    return 'Ajouter un $storeCategory';
  }

  @override
  String store_all_bar_title(Object storeCategory) {
    return 'Tous les $storeCategory';
  }

  @override
  String store_bar_title(Object storeCategory) {
    return 'Configuration $storeCategory';
  }

  @override
  String store_adress_hinter_text(Object storeCategory) {
    return 'Veuillez saisir l\'adresse du $storeCategory';
  }

  @override
  String store_description_hinter_text(Object storeCategory) {
    return 'Veuillez saisir la description du $storeCategory';
  }

  @override
  String store_email_hinter_text(Object storeCategory) {
    return 'Veuillez saisir l\'email du $storeCategory';
  }

  @override
  String store_name_hinter_text(Object storeCategory) {
    return 'Veuillez saisir le nom du $storeCategory';
  }

  @override
  String store_name_label(Object storeCategory) {
    return 'Nom du $storeCategory';
  }

  @override
  String store_phone_hinter_text(Object storeCategory) {
    return 'Veuillez saisir le téléphone du $storeCategory';
  }

  @override
  String store_add_success_message(Object storeCategory) {
    return '$storeCategory ajouté avec succès';
  }

  @override
  String store_type(Object storeCategory) {
    return 'Type $storeCategory';
  }

  @override
  String get description_title => 'Description';

  @override
  String get description_hint_text => 'Veuillez saisir la Description';

  @override
  String get search_title => 'Rechercher';

  @override
  String get company_adresse_label => 'Adresse';

  @override
  String get company_label_phone => 'Téléphone';

  @override
  String get company_label_email => 'Email';

  @override
  String get success_send_message_title => 'Message envoyée';

  @override
  String get success_send_message_message => 'Merci pour votre message';

  @override
  String get success_registration_new_user =>
      'Votre Compte a été créer avec succes';

  @override
  String get success_login_message => 'Connexion réussie';

  @override
  String get success_login_reset_password => 'Lien envoyé avec Succes';

  @override
  String get login_forget_password_txt =>
      'Saisissez votre adresse e-mail et nous vous enverrons un lien pour réinitialiser votre mot de passe ';

  @override
  String get error_send_mail_title => 'Erreur d\'Authentification';

  @override
  String get error_send_mail_message =>
      'Vous devez être enregistrer pour utilisé cette fonctionnalité';

  @override
  String get error_input_hint_message => 'Veuillez entrer votre message.';

  @override
  String get error_firebase_initialisation =>
      'Erreur Initialisation FirebaseAuth ';

  @override
  String get error_login_message => 'Échec de la connexion';

  @override
  String get error_register_title => 'Erreur d\'enregistrement';

  @override
  String get error_register_with_phone_message =>
      'Echec d\'enregistrement de votre numéro de téléphone, Veuillez réessayer svp !';

  @override
  String get error_application => 'Il y a plus d\'un Super Admin';

  @override
  String get error_register_with_email_message =>
      'Echec d\'enregistrement de votre email, Veuillez réessayer svp !';

  @override
  String get error_authorization => 'Access Non Autorisé';

  @override
  String get error_occur => 'Une erreur s\'est produite';

  @override
  String get error_send_formular => 'Veuillez Remplir le formulaire svp';

  @override
  String get error_show_formular_title => 'Erreur Page';

  @override
  String get error_show_formular =>
      'Une Erreur s\'est produite lors du chargement de la page';

  @override
  String get label_login_facebook => 'Facebook';

  @override
  String get label_login_google => 'Google';

  @override
  String get btn_close_label => 'Fermer';

  @override
  String get btn_send_label => 'Envoyer';

  @override
  String get btn_register_label => 'Enregistrer';

  @override
  String get btn_add_contact => 'Ajouter un Contact';

  @override
  String get btn_add_pressing_service => 'Ajouter un Service';

  @override
  String get verify_otp => 'Envoyer Code';

  @override
  String get resend_code => 'Renvoyer Code';

  @override
  String get form_contact_title => 'Formulaire de Contact:';

  @override
  String get input_hint_first_name => 'Nom';

  @override
  String get input_hint_last_name => 'Prénom';

  @override
  String get input_hint_adress_email => 'Adresse Email';

  @override
  String get input_hint_message => 'Votre Message...';

  @override
  String get input_hint_adress => 'Adresse';

  @override
  String get input_hint_middle_name => 'Surnom';

  @override
  String get input_hint_quartier => 'Quartier';

  @override
  String get input_hint_longitude => 'Longitude';

  @override
  String get input_hint_latitude => 'Latitude';

  @override
  String get movegui_info_title =>
      'MoveGui – Livraison & Transport à Moto en Guinée';

  @override
  String get movegui_info_text_1 =>
      'MoveGui est une entreprise innovante spécialisée dans la livraison de nourriture et le transport à moto en Guinée.Notre mission est de rendre la livraison plus accessible, plus transparente et plus économique pour tous.';

  @override
  String get movegui_info_text_2 =>
      'Nous proposons un tarif fixe pour chaque course, quelle que soit la distance, garantissant une transparence totale pour nos clients.Plus de surprises sur le prix, juste un service rapide, fiable et simple.';

  @override
  String get movegui_info_text_3 =>
      'Grâce à nos partenariats avec des restaurants locaux, nous offrons des livraisons à moindre coût tout en soutenant l’économie locale.MoveGui, c’est la fusion parfaite entre technologie, accessibilité et efficacité.';

  @override
  String get movegui_panel => 'Paneau de Configuration Movegui';

  @override
  String get movegui_panel_mobile => 'Panneau de Configuration ';

  @override
  String get deactivate_button_title => 'Service Indisponible';

  @override
  String get deactivate_button_message => 'Service indisponible pour le moment';

  @override
  String get deactivate_button_attach_message => 'Bientôt disponible';

  @override
  String get activate_button_attach_message => 'Disponible';

  @override
  String get category_courses_name => 'Courses';

  @override
  String get category_restaurant_name => 'Restaurant';

  @override
  String get category_patisserie_name => 'Patisserie';

  @override
  String get category_supermarche_name => 'Super Marché';

  @override
  String get category_supplier_name => 'Fournisseur';

  @override
  String get category_pressing_name => 'Pressing';

  @override
  String get category_discovery_name => 'Discovery';

  @override
  String get category_boulangerie_name => 'Boulangerie';

  @override
  String get category_pharmacy_name => 'Pharmacie';

  @override
  String get category_beauty_name => 'Beauté & Soins';

  @override
  String get categroy_store_name => 'Magasin';

  @override
  String get category_shop_name => 'Boutique';

  @override
  String get category_wholesaler_name => 'Grossiste';

  @override
  String get category_profession_name => 'Metiers';

  @override
  String get category_fast_food_name => 'Fast Food';

  @override
  String get category_category_name => 'Categorie';

  @override
  String get category_ingredient_name => 'Ingrédients';

  @override
  String get category_pastry_name => 'Patisserie';

  @override
  String get category_product_name => 'Produits';

  @override
  String get category_recipe_name => 'Recettes';

  @override
  String get category_super_market_name => 'Super Marchés';

  @override
  String get category_admin_manager => 'Admin';

  @override
  String get category_employe_manager => 'Employé';

  @override
  String get category_buisiness_manager => 'Manager';

  @override
  String get tooltip_add => 'Cliquez ici pour Ajouter';

  @override
  String get tooltip_all => 'Cliquez ici pour voir Tout';

  @override
  String get notification_title => 'Notifications';

  @override
  String get home_title => 'Accueil';

  @override
  String get movegui_title => 'Movegui';

  @override
  String get command_title => 'Commande';

  @override
  String get delivery_title => 'Livraison';

  @override
  String get courier_title => 'Courses';

  @override
  String get my_orders_title => 'Mes Commandes';

  @override
  String get my_deliveries_title => 'Mes Livraisons';

  @override
  String get profile_title => 'Profil';

  @override
  String get navigation_menu_tooltip => 'Navigation Menu';

  @override
  String get login_title => 'Connexion';

  @override
  String get register_title => 'Enregistrement';

  @override
  String get forget_password_title => 'Mot de pass Oublié';

  @override
  String get dashbord_title => 'Panneau de Configuration';

  @override
  String get register_admin_title => 'Enregistrement Admin';

  @override
  String get register_employe_title => 'Enregistrement Employé';

  @override
  String get address_office_title => 'Bureau';

  @override
  String get address_neighbor_title => 'Voisin';

  @override
  String get address_home_title => 'Maison';

  @override
  String get address_other_title => 'Autre';

  @override
  String get label_login_forget_password => 'Mot de pass oublier?';

  @override
  String get label_login => 'se connecter';

  @override
  String get label_login_connect_using => 'Ou connectez-vous via';

  @override
  String get label_login_invite => 'Invité ?';

  @override
  String get label_login_new_user => 'Nouveau ?';

  @override
  String get label_registration => 'Enregistrez-vous';

  @override
  String get label_enter_your_code => 'Entrez votre Code:';

  @override
  String get label_name => 'Nom';

  @override
  String get lable_username => 'Nom Utilisateur';

  @override
  String get label_adress => 'Adresse';

  @override
  String get label_email => 'Email';

  @override
  String get label_phone => 'Téléphone';

  @override
  String get label_role => 'Role';

  @override
  String get label_firstname => 'Nom';

  @override
  String get label_lastname => 'Prénom';

  @override
  String get label_district => 'Quartier';

  @override
  String get label_municipality => 'Commune';

  @override
  String get exception_login_message =>
      'Les identifiants utilisateur fournis sont incorrects, veuillez verifier votre email et mot de pass';

  @override
  String get tooltip_sign_in_with_google => 'Se connecter avec Google';

  @override
  String get tooltip_sign_in_with_facebook => 'Se connecter avec Facebook';

  @override
  String get tooltip_sign_in => 'Cliquez ici pour se connecter';

  @override
  String get tooltip_forget_password =>
      'Cliquez Ici pour réinitialiser votre mot de pass :)';

  @override
  String get tooltip_registration => 'Cliquez ici pour vous enregistrer :)';

  @override
  String get tooltip_btn_send => 'Cliquez ici pour envoyer votre code';

  @override
  String get tooltip_btn_add_contact => 'Ajouter un Nouveau Contact de plus';

  @override
  String get tooltip_btn_add_pressing_service => 'Ajouter un service de plus';

  @override
  String get profile_menu_invite_people => 'Inviter un proche';

  @override
  String get profile_menu_orders => 'Commades';

  @override
  String get profile_menu_message => 'Messages de diffusion';

  @override
  String get profile_menu_important => 'Important';

  @override
  String get profile_menu_devices => 'Appareils connectés';

  @override
  String get profile_menu_account => 'Compte';

  @override
  String get profile_menu_confidentiality => 'Confidentialité';

  @override
  String get profile_menu_discussions => 'Discussions';

  @override
  String get profile_menu_delete_account => 'Supprimer Compte';

  @override
  String get profile_menu_logout => 'Deconnexion';

  @override
  String get profile_menu_login => 'Connexion';

  @override
  String get add => 'Ajouter';

  @override
  String get add_all => 'Tout afficher';

  @override
  String get menu_main => 'Acceuil';

  @override
  String get menu_store_type => 'Types magasins';

  @override
  String get menu_store_categories => 'Magasins Categories';

  @override
  String get menu_restaurant_type => 'Restaurant Type';

  @override
  String get menu_menu => 'Menus';

  @override
  String get day_lundi => 'Lundi';

  @override
  String get day_mardi => 'Mardi';

  @override
  String get day_mercredi => 'Mercredi';

  @override
  String get day_jeudi => 'Jeudi';

  @override
  String get day_vendredi => 'Vendredi';

  @override
  String get day_samedi => 'Samedi';

  @override
  String get day_dimanche => 'Dimanche';

  @override
  String get last_orders => 'Dernières Commandes';

  @override
  String get message_movegui_title => '<p>Bienvenue sur Movegui</p>';

  @override
  String get message_movegui_link => 'Créer mon mot de passe';

  @override
  String get message_movegui =>
      'Merci de nous faire confiance l\'équipe MoveGui';
}
