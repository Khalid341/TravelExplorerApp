import 'package:flutter/material.dart';
import 'home_page.dart';
import 'favorites_page.dart';
import 'destination.dart';
import 'api_service.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Destination> _destinations = [];
  List<Destination> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadDestinations();
  }

  Future<void> _loadDestinations() async {
    try {
      final destinations = await ApiService.fetchDestinations();
      setState(() {
        _destinations = destinations;
      });
    } catch (e) {
      print('Error in _loadDestinations: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load destinations: $e')),
      );
    }
  }

  void _toggleFavorite(Destination destination) {
    setState(() {
      destination.isFavorite = !destination.isFavorite;
      if (destination.isFavorite) {
        if (!_favorites.contains(destination)) {
      _favorites.add(destination);
      }
      } else {
      _favorites.removeWhere((d) => d.countryCode == destination.countryCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(
            destinations: _destinations,
            onFavoriteToggle: _toggleFavorite,
          ),
          FavoritesPage(
            favorites: _favorites,
            onFavoriteToggle: _toggleFavorite,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}