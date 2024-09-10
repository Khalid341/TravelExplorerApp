import 'package:travelapp/tour_activity.dart';

class City {
  final String name;
  final String imageUrl;
  final List<TourActivity> activities;

  City({
    required this.name,
    required this.imageUrl,
    required this.activities,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    var activitiesList = json['activities'] as List;
    List<TourActivity> activities = activitiesList
        .map((activityJson) => TourActivity.fromJson(activityJson))
        .toList();

    return City(
      name: json['name'],
      imageUrl: json['imageUrl'] ?? '',
      activities: activities,
    );
  }
}