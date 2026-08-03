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
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/api_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:uuid/uuid.dart';

class SeedService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ApiService api;
  final Faker faker;

  SeedService({required this.api, required this.faker});

  Future<PressingModel> generatePressing() async => PressingModel(
    id: Uuid().v4(),
    name: faker.company.name(),
    createdAt: DateTime.now(),
    description: faker.company.random.fromPattern(['description']),
    address: await getgeneratedAdress(),
    staff: [
      await getGeneratedUserModel()
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
    rating: 0,
    reviewCount: 0,
  );

  Future<PressingServiceModel> getGeneratedPressingService() async =>
      PressingServiceModel(
        id: Uuid().v4(),
        product: await generatePressingArticle(),
        serviceType: await generatePressingTypeModel(),
        minPrice: 1000,
        maxPrice: 5000,
        basePrice: 1000,
        estimatedDuration: Duration(),
        name: faker.food.restaurant(),
        createdAt: DateTime.now(),
      );

  Future<PersonModel> getGeneratedPerson() async => PersonModel(
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
        adressType: 'h',
      ),
    ],
  );

  Future<AdressModel> getgeneratedAdress() async => AdressModel(
    address: faker.address.streetName(),
    id: Uuid().v4(),
    name: faker.address.streetAddress(),
    createdAt: DateTime.now(),
    district: faker.address.city(),
    minucipality: 'di',
    geoCordinates: GeoCordinatesModel(
      longitude: faker.geo.longitude(),
      latitude: faker.geo.latitude(),
    ),
    adressType: 'h',
  );

  Future<UserModel> getGeneratedUserModel() async => UserModel(
    updatedAt: DateTime.now(),
    id: Uuid().v4(),
    name: faker.person.name(),
    createdAt: DateTime.now(),
    username: null,
    isVerified: false,
    role: UserRole.Guest,
    personModel: await getGeneratedPerson()
  );

  Future<PressingServiceTypeModel> generatePressingTypeModel() async =>PressingServiceTypeModel(
          id: Uuid().v4(),
          name: faker.lorem.word(),
          description: faker.job.title(),
          pricingType: PricingType.fixed,
          createdAt: DateTime.now(),
        ); 

        Future<PressingArticleModel> generatePressingArticle() async => PressingArticleModel(
          id: Uuid().v4(),
          name: faker.lorem.word(),
          createdAt: DateTime.now(),
          price: faker.randomGenerator.decimal(scale: 2),
          supplierId: Uuid().v4(),
          imageUrl: faker.image.loremPicsum(),
          category: faker.company.name(),
          isAvailable: true,
          currency: 'GNF',
        );
}