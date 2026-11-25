import 'package:cloud_firestore/cloud_firestore.dart';

class GeoCordinatesModel {
  final double? longitude;
  final double? latitude;

  GeoCordinatesModel({required this.longitude, required this.latitude});

  Map<String, dynamic> toJson() => {
    'longitude': longitude,
    'latitude': latitude,
  };

  factory GeoCordinatesModel.fromJson(Map<String, dynamic> json) =>
      GeoCordinatesModel(
        longitude: json['longitude'],
        latitude: json['latitude'],
      );

  GeoPoint get geoPoint {
    return GeoPoint(latitude ?? 0.0, longitude ?? 0.0);
  }
}
