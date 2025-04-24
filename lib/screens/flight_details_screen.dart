import 'package:flutter/material.dart';
import '../models/flight_model.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(
              title: 'From',
              value: '${flight.departureAirport} (${flight.departureCity})',
            ),
            DetailRow(
              title: 'To',
              value: '${flight.arrivalAirport} (${flight.arrivalCity})',
            ),
            DetailRow(title: 'Status', value: flight.status),
            DetailRow(title: 'Departure Time', value: formatTime(flight.departureTime)),
            DetailRow(title: 'Arrival Time', value: formatTime(flight.arrivalTime)),
            SizedBox(height: 24),
            Center(
              child: Icon(Icons.flight_takeoff, size: 64, color: Colors.indigo.shade300),
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

  const DetailRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text('$title:', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
