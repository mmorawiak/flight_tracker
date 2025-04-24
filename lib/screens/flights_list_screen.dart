import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import 'flight_details_screen.dart';

class FlightsListScreen extends StatelessWidget {
  final List<Flight> flights;

  const FlightsListScreen({super.key, required this.flights});

  String _formatTime(DateTime? time) {
    if (time == null) return '--:--';
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Results')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text('${flights.length} flights found'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text('${flight.airlineName} ${flight.flightNumber}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${flight.flightDate}'),
                        Text('${flight.departureAirport} (${flight.departureCity}) → ${flight.arrivalAirport} (${flight.arrivalCity})'),
                        SizedBox(height: 4),
                        Text(
                          '${_formatTime(flight.departureTime)} → ${_formatTime(flight.arrivalTime)}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    trailing: Text(flight.status),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FlightDetailsScreen(flight: flight),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
