import 'package:flutter/material.dart';
import 'api_service.dart';
import 'city.dart';
import 'destination.dart';
import 'tour_activity.dart';

class CitiesPage extends StatelessWidget {
  final Destination destination;

  CitiesPage({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cities in ${destination.name}')),
      body: FutureBuilder<List<City>>(
        future: ApiService.fetchCities(destination.countryCode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cities available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                City city = snapshot.data![index];
                return ExpansionTile(
                  leading: Image.network(city.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(city.name),
                  children: [
                    FutureBuilder<List<TourActivity>>(
                      future: ApiService.fetchToursAndActivities(city.name),
                      builder: (context, activitySnapshot) {
                        if (activitySnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (activitySnapshot.hasError) {
                          return Center(child: Text('Error: ${activitySnapshot.error}'));
                        } else if (!activitySnapshot.hasData || activitySnapshot.data!.isEmpty) {
                          return Center(child: Text('No tours or activities available'));
                        } else {
                          return Column(
                            children: activitySnapshot.data!.map((activity) {
                              return ListTile(
                                leading: Image.network(activity.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                                title: Text(activity.name),
                                subtitle: Text(activity.description),
                                trailing: Text('\$${activity.price.toStringAsFixed(2)}'),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}