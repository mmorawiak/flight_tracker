import 'package:flutter/material.dart';
import '../services/flight_service.dart';
import 'flight_details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  bool _loading = false;
  String? _error;

  void _searchFlight() async {
    final flightNumber = _controller.text.trim();
    if (flightNumber.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final flight = await FlightService.fetchFlight(flightNumber);
      if (flight == null) {
        setState(() => _error = 'Flight not found.');
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FlightDetailsScreen(flight: flight),
        ),
      );
    } catch (e) {
      setState(() => _error = 'Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Flight Number (e.g. LO123)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _searchFlight,
              child: _loading ? CircularProgressIndicator() : Text('Search'),
            ),
            if (_error != null) ...[
              SizedBox(height: 16),
              Text(_error!, style: TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}
