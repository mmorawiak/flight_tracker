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

  final Map<String, String> statusTranslationMap = {
    '': '',
    'Zaplanowany': 'scheduled',
    'W trakcie': 'active',
    'Wylądował': 'landed',
    'Anulowany': 'cancelled',
  };

  void _searchFlights() async {
    final departure = _departureController.text.trim();
    final arrival = _arrivalController.text.trim();
    final airline = _airlineController.text.trim();
    final status = statusTranslationMap[_selectedStatus] ?? '';

    if (departure.isEmpty && arrival.isEmpty && airline.isEmpty && status.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Proszę podać przynajmniej jeden filtr')),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nie znaleziono lotów')),
        );
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
        title: Text('Wyszukiwarka lotów'),
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
              decoration: InputDecoration(
                labelText: 'Kod IATA lotniska wylotu (np. WRO)',
                prefixIcon: Icon(Icons.flight_takeoff),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _arrivalController,
              decoration: InputDecoration(
                labelText: 'Kod IATA lotniska przylotu (np. WAW)',
                prefixIcon: Icon(Icons.flight_land),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _airlineController,
              decoration: InputDecoration(
                labelText: 'Kod IATA linii lotniczej (np. LO)',
                prefixIcon: Icon(Icons.airlines),
              ),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedStatus.isEmpty ? null : _selectedStatus,
              items: statusTranslationMap.keys.map((plStatus) {
                return DropdownMenuItem(
                  value: plStatus,
                  child: Text(plStatus.isEmpty ? 'Dowolny status' : plStatus),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedStatus = val ?? ''),
              decoration: InputDecoration(
                labelText: 'Status lotu',
                prefixIcon: Icon(Icons.info_outline),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _searchFlights,
              child: _loading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Szukaj lotów'),
            ),
          ],
        ),
      ),
    );
  }
}
