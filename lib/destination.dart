import 'package:travelapp/city.dart';

import 'tour_activity.dart';

class Destination {
  final String name;
  final String capital;
  final String region;
  final List<City> cities;
  final String countryCode;
  final String flagImageUrl;
  bool isFavorite;
  List<TourActivity> toursAndActivities;

  Destination({
    required this.name,
    required this.capital,
    required this.region,
    required this.countryCode,
    required this.flagImageUrl,
    required this.cities,
    this.isFavorite = false,
    this.toursAndActivities = const [],
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    var citiesList = json['cities'] as List;
    List<City> cities = citiesList.map((cityJson) => City.fromJson(cityJson))
        .toList();
    return Destination(
      name: json['name'],
      capital: json['capital'],
      region: json['region'] ?? '',
      countryCode: json['countryCode'] ?? '',
      flagImageUrl: json['flagUrl'],
      cities: cities,
    );
  }
}