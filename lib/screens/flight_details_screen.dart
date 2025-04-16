import 'package:flutter/material.dart';
import '../models/flight_model.dart';

class FlightDetailsScreen extends StatelessWidget {
  final Flight flight;

  const FlightDetailsScreen({required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(title: 'Flight Number', value: flight.flightNumber),
            DetailRow(title: 'Airline', value: flight.airlineName),
            DetailRow(title: 'Status', value: flight.status),
            SizedBox(height: 12),
            Text('Departure', style: Theme.of(context).textTheme.titleMedium),
            DetailRow(title: 'Airport', value: flight.departureAirport),
            DetailRow(title: 'Time', value: flight.departureTime),
            SizedBox(height: 12),
            Text('Arrival', style: Theme.of(context).textTheme.titleMedium),
            DetailRow(title: 'Airport', value: flight.arrivalAirport),
            DetailRow(title: 'Time', value: flight.arrivalTime),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$title: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
