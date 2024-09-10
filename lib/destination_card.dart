import 'package:flutter/material.dart';
import 'destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onFavoriteToggle;

  const DestinationCard({
    Key? key,
    required this.destination,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: destination.flagImageUrl.isNotEmpty
            ? Image.network(
          destination.flagImageUrl,
          width: 50,
          height: 30,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.flag); // Fallback icon if image fails to load
          },
        )
            : Icon(Icons.flag), // Fallback icon if no image URL is available
        title: Text(destination.name),
        // subtitle: Text('Country Code: ${destination.countryCode}'),
        trailing: IconButton(
          icon: Icon(
            destination.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: destination.isFavorite ? Colors.red : null,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}