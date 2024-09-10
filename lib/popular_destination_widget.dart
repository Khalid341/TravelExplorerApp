import 'package:flutter/material.dart';
import 'api_service.dart';
import 'destination.dart';
import 'destination_card.dart';
import 'all_countries_page.dart';

class PopularDestinationWidget extends StatelessWidget {
  final List<Destination> destinations;
  final Function(Destination) onFavoriteToggle;

  const PopularDestinationWidget({
    Key? key,
    required this.destinations,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Popular Destinations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllCountriesPage(
                        destinations: destinations,
                        onFavoriteToggle: onFavoriteToggle,
                      ),
                    ),
                  );
                },
                child: Text('View all'),
              ),
            ],
          ),
        ),
        Column(
          children: destinations.take(5).map((destination) => DestinationCard(
            destination: destination,
            onFavoriteToggle: () => onFavoriteToggle(destination),
          )).toList(),
        ),
      ],
    );
  }
}