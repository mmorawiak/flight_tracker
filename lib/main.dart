import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/search_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const FlightTrackerApp());
}

class FlightTrackerApp extends StatelessWidget {
  const FlightTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Tracker',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: SearchScreen(),
    );
  }
}
