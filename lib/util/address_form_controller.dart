import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';

class AddressFormController extends FormController<AdressModel>{
  final district = TextEditingController();
  final longitude = TextEditingController();
  final latitude = TextEditingController();
  final address = TextEditingController();
  final addressFocusNode = FocusNode();
  final districtFocus = FocusNode();
  final longitudeFocusNode = FocusNode();
  final latitudeFocusNode = FocusNode();
   String selectedType = 'h';
   String selectedMunicipality = 'di';

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
     longitude.text = model.geoCordinates!.longitude.toString();
     latitude.text = model.geoCordinates!.latitude.toString();
     district.text = model.district!;
     address.text = model.address;
  }
}
