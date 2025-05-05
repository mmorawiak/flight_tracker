import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import '../screens/flight_map_screen.dart';

class FlightDetailsScreen extends StatelessWidget {
  final Flight flight;

  const FlightDetailsScreen({super.key, required this.flight});

  String formatTime(DateTime? time) {
    if (time == null) return '--';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${flight.airlineName} ${flight.flightNumber}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DetailRow(
              title: 'Wylot z',
              value: '${flight.departureAirport} (${flight.departureCity})',
              icon: Icons.flight_takeoff,
            ),
            DetailRow(
              title: 'Lot do',
              value: '${flight.arrivalAirport} (${flight.arrivalCity})',
              icon: Icons.flight_land,
            ),
            DetailRow(
              title: 'Status',
              value: flight.status,
              icon: Icons.info_outline,
            ),
            DetailRow(
              title: 'Czas wylotu',
              value: formatTime(flight.departureTime),
              icon: Icons.schedule,
            ),
            DetailRow(
              title: 'Czas przylotu',
              value: formatTime(flight.arrivalTime),
              icon: Icons.access_time,
            ),
            SizedBox(height: 32),
            Center(
              child: Icon(Icons.airplanemode_active, size: 64, color: Colors.indigo.shade300),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.map),
                label: Text('Pokaż trasę lotu'),
                onPressed: () {
                  if (flight.departureLatitude != null && flight.arrivalLatitude != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlightMapScreen(
                          departureLatitude: flight.departureLatitude!,
                          departureLongitude: flight.departureLongitude!,
                          arrivalLatitude: flight.arrivalLatitude!,
                          arrivalLongitude: flight.arrivalLongitude!,
                          liveLatitude: flight.liveLatitude,
                          liveLongitude: flight.liveLongitude,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Brak współrzędnych dla tego lotu')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const DetailRow({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 2),
              child: Icon(icon, size: 20, color: Colors.indigo.shade400),
            ),
          SizedBox(
            width: 120,
            child: Text('$title:', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
