import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';
import 'package:movegui_admin_panel/services/api_service.dart';
import 'package:uuid/uuid.dart';

class SeedService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ApiService api;
  final Faker faker;

  SeedService({required this.api, required this.faker});

  /*
  Future<void> generateUsers(int count) async {
    final faker = Faker();

    for (int i = 0; i < count; i++) {
      final user = {
        'name': faker.person.name(),
        'email': faker.internet.email(),
        'phone': faker.phoneNumber.us(),
        'address': faker.address.streetAddress(),
        'createdAt': Timestamp.now(),
        'isPremium': faker.randomGenerator.boolean(),
        'age': faker.randomGenerator.integer(60, min: 18),
      };

      await firestore.collection('users').add(user);
    }
  }
  */

  Future<PressingModel> generatePressing() async => PressingModel(
    id: Uuid().v4(),
    name: faker.company.name(),
    createdAt: DateTime.now(),
    description: faker.company.random.fromPattern(['description']),
    address: AdressModel(
      address: faker.address.streetName(),
      id: Uuid().v4(),
      name: faker.address.streetAddress(),
      createdAt: DateTime.now(),
      district: faker.address.city(),
      minucipality: faker.address.city(),
      geoCordinates: GeoCordinatesModel(
        longitude: faker.geo.longitude(),
        latitude: faker.geo.latitude(),
      ),
    ),
    contacts: [
      PersonModel(
        id: Uuid().v4(),
        name: faker.person.name(),
        createdAt: DateTime.now(),
        firstName: faker.person.firstName(),
        lastName: faker.person.lastName(),
        profileImageUrl: faker.image.toString(),
        email: faker.internet.email(),
        phone: faker.phoneNumber.de(),
        gender: 'm',
        birthDate: faker.date.dateTime(),
        addresses: [
          AdressModel(
            address: faker.address.streetName(),
            id: Uuid().v4(),
            name: faker.address.streetAddress(),
            createdAt: DateTime.now(),
            district: faker.address.city(),
            minucipality: faker.address.city(),
            geoCordinates: GeoCordinatesModel(
              longitude: faker.geo.longitude(),
              latitude: faker.geo.latitude(),
            ),
          ),
        ],
      ),
    ],
    email: faker.internet.email(),
    imageUrl: faker.image.toString(),
    phone: faker.phoneNumber.de(),
    weeklyHours: [
      OpenHoursModel(
        day: 'lundi',
        openTime: TimeOfDay(hour: 09, minute: 00),
        closeTime: TimeOfDay(hour: 17, minute: 30),
      ),
    ],
    storeType: RestaurantTypeModel(
      id: Uuid().v4(),
      name: faker.company.name(),
      createdAt: DateTime.now(),
    ),
  );

  Future<PressingServiceModel> getGeneratedPressingService() async =>
      PressingServiceModel(
        id: Uuid().v4(),
        article: PressingArticleModel(
          id: Uuid().v4(),
          name: faker.lorem.word(),
          iconUrl: 'iconUrl',
          createdAt: DateTime.now(),
        ),
        serviceType: PressingServiceTypeModel(
          id: Uuid().v4(),
          name: faker.lorem.word(),
          description: faker.job.title(),
          pricingType: PricingType.fixed.name,
          createdAt: DateTime.now(),
        ),
        minPrice: 1000,
        maxPrice: 5000,
        basePrice: 1000,
        estimatedDuration: Duration(),
        name: faker.food.restaurant(),
        createdAt: DateTime.now(),
      );
}
