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
      appBar: AppBar(title: Text('Wyniki wyszukiwania')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text('${flights.length} lotów znaleziono'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      '${flight.airlineName} ${flight.flightNumber}',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('Data: ${flight.flightDate}'),
                        Text(
                          '${flight.departureAirport} (${flight.departureCity}) → ${flight.arrivalAirport} (${flight.arrivalCity})',
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${_formatTime(flight.departureTime)} → ${_formatTime(flight.arrivalTime)}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        flight.status,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
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
