import 'package:flutter/material.dart';
import 'package:travelapp/tour_activity.dart';
import 'destination.dart';

class ToursActivitiesPage extends StatelessWidget {
  final Destination destination;

  ToursActivitiesPage({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${destination.name} - Tours & Activities'),
      ),
      body: Column(
        children: [
          Image.network(destination.flagImageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Capital: ${destination.capital}', style: Theme.of(context).textTheme.titleMedium),
          ),
          Expanded(
            child: destination.toursAndActivities.isEmpty
                ? Center(child: Text('No tours or activities available'))
                : ListView.builder(
              itemCount: destination.toursAndActivities.length,
              itemBuilder: (context, index) {
                TourActivity activity = destination.toursAndActivities[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(activity.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(activity.name),
                    subtitle: Text(activity.description),
                    trailing: Text('\$${activity.price.toStringAsFixed(2)}'),
                    onTap: () {
                      // You can add navigation to a detail page here if needed
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}