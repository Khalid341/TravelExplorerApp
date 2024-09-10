import 'package:flutter/material.dart';

class CurrentLocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue),
          SizedBox(width: 8),
          Text('Current Location'),
          Spacer(),
          CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/200'),
          ),
        ],
      ),
    );
  }
}