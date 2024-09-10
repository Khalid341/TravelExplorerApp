import 'package:flutter/material.dart';
import 'destination.dart';
import 'city.dart';
import 'tour_activity.dart';

class CountryDetailsPage extends StatelessWidget {
  final Destination destination;

  const CountryDetailsPage({Key? key, required this.destination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              destination.flagImageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, size: 200),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Capital: ${destination.capital}',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 16),
                  Text('Cities',
                      style: Theme.of(context).textTheme.titleLarge),
                  ...destination.cities.map((city) => _buildCitySection(city)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCitySection(City city) {
    return ExpansionTile(
      title: Text(city.name),
      children: [
        if (city.imageUrl.isNotEmpty)
          Image.network(
            city.imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.error, size: 150),
          ),
        ...city.activities.map((activity) => _buildActivityTile(activity)).toList(),
      ],
    );
  }

  Widget _buildActivityTile(TourActivity activity) {
    return ListTile(
      leading: activity.imageUrl.isNotEmpty
          ? Image.network(
        activity.imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.error, size: 50),
      )
          : Icon(Icons.tour, size: 50),
      title: Text(activity.name),
      subtitle: Text(activity.description),
      trailing: Text('\$${activity.price.toStringAsFixed(2)}'),
    );
  }
}