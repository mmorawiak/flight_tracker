import 'package:flutter/material.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(FlightTrackerApp());
}

class FlightTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Tracker',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: SearchScreen(),
    );
  }
}
