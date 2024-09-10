import 'package:flutter/material.dart';
import 'city.dart';
import 'tour_activity.dart';

class CityDetailsScreen extends StatelessWidget {
  final City city;

  CityDetailsScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: Column(
        children: [
          if (city.imageUrl != null && city.imageUrl!.isNotEmpty)
            Image.network(
              city.imageUrl!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, size: 100),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: city.activities.length,
              itemBuilder: (context, index) {
                TourActivity activity = city.activities[index];
                return ListTile(
                  leading: activity.imageUrl != null && activity.imageUrl!.isNotEmpty
                      ? Image.network(
                    activity.imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error),
                  )
                      : Icon(Icons.image),
                  title: Text(activity.name),
                  subtitle: Text(activity.description),
                  trailing: Text('\$${activity.price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}