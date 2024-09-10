import 'package:flutter/material.dart';
import 'destination.dart';
import 'destination_card.dart';
import 'country_details_page.dart'; // Make sure to import this

class FavoritesPage extends StatelessWidget {
  final List<Destination> favorites;
  final Function(Destination) onFavoriteToggle;

  const FavoritesPage({
    Key? key,
    required this.favorites,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites yet'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountryDetailsPage(destination: favorites[index]),
                ),
              );
            },
            child: DestinationCard(
              destination: favorites[index],
              onFavoriteToggle: () => onFavoriteToggle(favorites[index]),
            ),
          );
        },
      ),
    );
  }
}