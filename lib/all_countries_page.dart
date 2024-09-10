import 'package:flutter/material.dart';
import 'destination.dart';
import 'destination_card.dart';

class AllCountriesPage extends StatefulWidget {
  final List<Destination> destinations;
  final Function(Destination) onFavoriteToggle;

  AllCountriesPage({required this.destinations, required this.onFavoriteToggle});

  @override
  _AllCountriesPageState createState() => _AllCountriesPageState();
}

class _AllCountriesPageState extends State<AllCountriesPage> {
  List<Destination> _filteredDestinations = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredDestinations = List.from(widget.destinations);
  }

  void _filterDestinations(String query) {
    setState(() {
      _searchQuery = query;
      _filteredDestinations = widget.destinations
          .where((destination) =>
          destination.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _handleFavoriteToggle(Destination destination) {
    widget.onFavoriteToggle(destination);
    setState(() {
      // Update the local list to reflect the change
      final index = _filteredDestinations.indexWhere((d) => d.countryCode == destination.countryCode);
      if (index != -1) {
        _filteredDestinations[index] = destination;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Countries'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterDestinations,
              decoration: InputDecoration(
                labelText: 'Search countries',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDestinations.length,
              itemBuilder: (context, index) {
                return DestinationCard(
                  destination: _filteredDestinations[index],
                  onFavoriteToggle: () => _handleFavoriteToggle(_filteredDestinations[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}