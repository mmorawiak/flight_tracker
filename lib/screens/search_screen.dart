import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../services/flight_service.dart';
import '../models/flight_model.dart';
import 'flights_list_screen.dart';
import 'login_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _departureController = TextEditingController();
  final _arrivalController = TextEditingController();
  final _airlineController = TextEditingController();
  String _selectedStatus = '';
  bool _loading = false;

  void _searchFlights() async {
    final departure = _departureController.text.trim();
    final arrival = _arrivalController.text.trim();
    final airline = _airlineController.text.trim();
    final status = _selectedStatus;

    if (departure.isEmpty && arrival.isEmpty && airline.isEmpty && status.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please provide at least one filter')));
      return;
    }

    setState(() => _loading = true);

    try {
      final flights = await FlightService.fetchFlightsByFilters(
        departure: departure,
        arrival: arrival,
        airline: airline,
        status: status,
      );

      if (flights.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No flights found')));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FlightsListScreen(flights: flights)),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
  final authBox = Hive.box('authBox');
  await authBox.put('isLoggedIn', false);

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
    (route) => false,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Wyloguj się',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _departureController,
              decoration: InputDecoration(labelText: 'Departure IATA (e.g. WRO)', border: OutlineInputBorder()),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _arrivalController,
              decoration: InputDecoration(labelText: 'Arrival IATA (e.g. WAW)', border: OutlineInputBorder()),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _airlineController,
              decoration: InputDecoration(labelText: 'Airline IATA (e.g. LO)', border: OutlineInputBorder()),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedStatus.isEmpty ? null : _selectedStatus,
              items: ['', 'scheduled', 'active', 'landed', 'cancelled']
                  .map((status) => DropdownMenuItem(value: status, child: Text(status.isEmpty ? 'Any Status' : status)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedStatus = val ?? ''),
              decoration: InputDecoration(labelText: 'Flight Status', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _searchFlights,
              child: _loading ? CircularProgressIndicator() : Text('Search Flights'),
            ),
          ],
        ),
      ),
    );
  }
}
