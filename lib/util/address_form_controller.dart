import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/consts/constants.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';
import 'package:uuid/uuid.dart';

class AddressFormController extends FormController<AdressModel> {
  final district = TextEditingController();
  final longitude = TextEditingController();
  final latitude = TextEditingController();
  final address = TextEditingController();
  final addressFocusNode = FocusNode();
  final districtFocus = FocusNode();
  final longitudeFocusNode = FocusNode();
  final latitudeFocusNode = FocusNode();
  String? id = Uuid().v4();
  DateTime? createdAt;
  String selectedType = 'h';
  String selectedMunicipality = 'di';
  bool isRegisted = false;
  bool isDefault = false;

  void dispose() {
    district.dispose();
    longitude.dispose();
    latitude.dispose();
    address.dispose();
  }

  void clear() {
    district.clear();
    longitude.clear();
    latitude.clear();
    address.clear();
  }

  @override
  Future<void> setData(AdressModel model) async {
    longitude.text = model.geoCordinates?.longitude?.toString() ?? '';
    latitude.text = model.geoCordinates?.latitude?.toString() ?? '';
    district.text = model.district!;
    address.text = model.address;
    selectedType = model.adressType;
    selectedMunicipality =
        model.minucipality; // getLabelCommune(model.minucipality);
    id = model.id;
    isRegisted = true;
    isDefault = model.isDefault;
  }

  bool isEmpty() {
    return address.text.isEmpty &&
        latitude.text.isEmpty &&
        district.text.isEmpty &&
        longitude.text.isEmpty;
  }

  bool isValid() {
    return address.text.isNotEmpty &&
        latitude.text.isNotEmpty &&
        district.text.isNotEmpty &&
        longitude.text.isNotEmpty;
  }



  String getLabelCommune(String value) {
    switch (value) {
      case COMMUNE_DIXINN:
        return 'di';
      case COMMUNE_GBESSIA:
        return 'gb';
      case COMMUNE_KALOUM:
        return 'ka';
      case COMMUNE_KAGBELEN:
        return 'kg';
      case COMMUNE_KASSA:
        return 'ks';
      case COMMUNE_LAMBANYI:
        return 'la';
      case COMMUNE_MATAM:
        return 'ma';
      case COMMUNE_MANEAH:
        return 'mn';
      case COMMUNE_MATOTO:
        return 'mt';
      case COMMUNE_RATOMA:
        return 'ra';
      case COMMUNE_SONFONIA:
        return 'so';
      case COMMUNE_SANOYAH:
        return 'sn';
      case COMMUNE_TOMBOLIA:
        return 'to';
      default:
        return '';
    }
  }
}
