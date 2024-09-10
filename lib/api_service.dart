import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:travelapp/tour_activity.dart';
import 'city.dart';
import 'destination.dart';

class ApiService {
  static Future<List<Destination>> fetchDestinations() async {
    try {
      // Load the JSON file from assets
      final String response = await rootBundle.loadString('assets/travel_data.json');
      print('JSON data loaded successfully');

      // Parse the JSON
      final data = await json.decode(response);
      print('JSON data decoded successfully');

      // Extract the list of countries
      final countriesData = data['countries'] as List<dynamic>;
      print('Number of countries found: ${countriesData.length}');

      // Convert each country data to a Destination object
      final destinations = countriesData.map((countryData) {
        try {
          return Destination.fromJson(countryData);
        } catch (e) {
          print('Error parsing country data: $e');
          print('Problematic country data: $countryData');
          return null;
        }
      }).whereType<Destination>().toList();

      print('Number of destinations created: ${destinations.length}');

      return destinations;
    } catch (e) {
      print('Error fetching destinations: $e');
      rethrow; // Re-throw the error so it can be caught by the UI
    }
  }
  static Future<List<City>> fetchCities(String countryName) async {
    try {
      final String response = await rootBundle.loadString('assets/travel_data.json');
      final data = await json.decode(response);

      final country = (data['countries'] as List<dynamic>).firstWhere(
            (country) => country['name'] == countryName,
        orElse: () => null,
      );

      if (country == null) {
        return [];
      }

      final citiesData = country['cities'] as List<dynamic>;
      final cities = citiesData.map((cityData) => City.fromJson(cityData)).toList();

      return cities;
    } catch (e) {
      print('Error fetching cities: $e');
      rethrow;
    }
  }




  static Future<List<TourActivity>> fetchToursAndActivities(String cityName) async {
    try {
      final String response = await rootBundle.loadString('assets/travel_data.json');
      final data = await json.decode(response);

      List<dynamic>? activitiesData;
      for (var country in data['countries']) {
        for (var city in country['cities']) {
          if (city['name'] == cityName) {
            activitiesData = city['activities'] as List<dynamic>?;
            break;
          }
        }
        if (activitiesData != null) break;
      }

      if (activitiesData == null) {
        return [];
      }

      final activities = activitiesData.map((activityData) => TourActivity.fromJson(activityData)).toList();

      return activities;
    } catch (e) {
      print('Error fetching tours and activities: $e');
      rethrow;
    }
  }
}
