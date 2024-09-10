import 'package:flutter/material.dart';
import 'country_details_page.dart';
import 'destination.dart';
import 'country_details_screen.dart';

class HomePage extends StatelessWidget {
  final List<Destination> destinations;
  final Function(Destination) onFavoriteToggle;

  HomePage({required this.destinations, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel App'),
      ),

      body: destinations.isEmpty

          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          Destination destination = destinations[index];
          return ListTile(
            leading: destination.flagImageUrl.isNotEmpty
                ? Image.network(
              destination.flagImageUrl,
              width: 50,
              height: 30,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.flag);
              },
            )
                : Icon(Icons.flag),
            title: Text(destination.name),
            subtitle: Text(destination.capital),
            trailing: IconButton(
              icon: Icon(
                destination.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: destination.isFavorite ? Colors.red : null,
              ),
              onPressed: () => onFavoriteToggle(destination),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountryDetailsPage(destination: destination),
                ),
              );
            },
          );
        },
      )
    );
  }
}