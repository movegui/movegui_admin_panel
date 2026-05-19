import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/services/api_service.dart';

class AddressService {
  final ApiService api;

  AddressService({required this.api});

  Future<GeoCordinatesModel?> getCoordinates(String address) async {
    final url =
        '${api.env.baseUrl}/movegui-253e0/us-central1/geocodeAddress'
        '?address=${Uri.encodeComponent(address)}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return GeoCordinatesModel(
        longitude: data['longitude'],
        latitude: data['latitude'],
      );
    }

    return null;
  }
}
