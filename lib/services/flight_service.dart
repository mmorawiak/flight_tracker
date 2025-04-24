import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flight_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlightService {
  static final String _apiKey = dotenv.env['AVIATIONSTACK_API_KEY'] ?? '';
  static const String _baseUrl = 'http://api.aviationstack.com/v1/flights';

  static Future<List<Flight>> fetchFlightsByFilters({
    String? departure,
    String? arrival,
    String? airline,
    String? status,
  }) async {
    final queryParameters = {
      'access_key': _apiKey,
      if (departure != null && departure.isNotEmpty) 'dep_iata': departure,
      if (arrival != null && arrival.isNotEmpty) 'arr_iata': arrival,
      if (airline != null && airline.isNotEmpty) 'airline_iata': airline,
      if (status != null && status.isNotEmpty) 'flight_status': status,
    };

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    print('REQUEST URL: $uri');

    List<Flight> testFlights = [
      Flight(
        flightNumber: 'LO33',
        airlineName: 'LOT Polish Airlines (TEST)',
        departureAirport: 'Warsaw Chopin Airport',
        arrivalAirport: "Chicago O'Hare International Airport",
        status: 'en-route (TEST)',
        departureCity: 'Warsaw',
        arrivalCity: 'Chicago',
        flightDate: DateTime.now().toIso8601String().substring(0, 10),
        departureTime: DateTime.now().subtract(Duration(hours: 3)),
        arrivalTime: DateTime.now().add(Duration(hours: 5)),
        departureLatitude: 52.1657,
        departureLongitude: 20.9671,
        arrivalLatitude: 41.9742,
        arrivalLongitude: -87.9073,
        liveLatitude: 55.0,
        liveLongitude: -30.0,
      ),
      Flight(
        flightNumber: 'BA283',
        airlineName: 'British Airways (TEST)',
        departureAirport: 'London Heathrow Airport',
        arrivalAirport: 'Los Angeles International Airport',
        status: 'scheduled (TEST)',
        departureCity: 'London',
        arrivalCity: 'Los Angeles',
        flightDate: DateTime.now().toIso8601String().substring(0, 10),
        departureTime: DateTime.now().add(Duration(hours: 3)),
        arrivalTime: DateTime.now().add(Duration(hours: 13)),
        departureLatitude: 51.4700,
        departureLongitude: -0.4543,
        arrivalLatitude: 33.9416,
        arrivalLongitude: -118.4085,
      ),
      Flight(
        flightNumber: 'SQ26',
        airlineName: 'Singapore Airlines (TEST)',
        departureAirport: 'Singapore Changi Airport',
        arrivalAirport: 'Frankfurt Airport',
        status: 'scheduled (TEST)',
        departureCity: 'Singapore',
        arrivalCity: 'Frankfurt',
        flightDate: DateTime.now().toIso8601String().substring(0, 10),
        departureTime: DateTime.now().add(Duration(hours: 5)),
        arrivalTime: DateTime.now().add(Duration(hours: 17)),
        departureLatitude: 1.3644,
        departureLongitude: 103.9915,
        arrivalLatitude: 50.0379,
        arrivalLongitude: 8.5622,
      ),
      Flight(
        flightNumber: 'DL173',
        airlineName: 'Delta Air Lines (TEST)',
        departureAirport: 'Tokyo Haneda Airport',
        arrivalAirport: 'Seattle-Tacoma International Airport',
        status: 'scheduled (TEST)',
        departureCity: 'Tokyo',
        arrivalCity: 'Seattle',
        flightDate: DateTime.now().toIso8601String().substring(0, 10),
        departureTime: DateTime.now().add(Duration(hours: 4)),
        arrivalTime: DateTime.now().add(Duration(hours: 12)),
        departureLatitude: 35.5494,
        departureLongitude: 139.7798,
        arrivalLatitude: 47.4502,
        arrivalLongitude: -122.3088,
      ),
      Flight(
        flightNumber: 'QF12',
        airlineName: 'Qantas (TEST)',
        departureAirport: 'Los Angeles International Airport',
        arrivalAirport: 'Sydney Kingsford Smith Airport',
        status: 'scheduled (TEST)',
        departureCity: 'Los Angeles',
        arrivalCity: 'Sydney',
        flightDate: DateTime.now().toIso8601String().substring(0, 10),
        departureTime: DateTime.now().add(Duration(hours: 6)),
        arrivalTime: DateTime.now().add(Duration(hours: 21)),
        departureLatitude: 33.9416,
        departureLongitude: -118.4085,
        arrivalLatitude: -33.9399,
        arrivalLongitude: 151.1753,
      ),
    ];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['error'] != null) {
        print("API Error: ${json['error']['message']}");
        return testFlights;
      }

      final flightsJson = json['data'] as List<dynamic>;

      for (var flightJson in flightsJson) {
        final depLat = flightJson['departure']?['latitude'];
        final depLng = flightJson['departure']?['longitude'];
        final arrLat = flightJson['arrival']?['latitude'];
        final arrLng = flightJson['arrival']?['longitude'];
        print('Flight geo: depLat=$depLat, depLng=$depLng, arrLat=$arrLat, arrLng=$arrLng');
        final liveLat = flightJson['live']?['latitude'];
        final liveLng = flightJson['live']?['longitude'];
        print('LIVE geo: liveLat=$liveLat, liveLng=$liveLng');
      }

      return [
        ...testFlights,
        ...flightsJson.map((json) => Flight.fromJson(json)).toList(),
      ];
    } else {
      print("Failed to load flights: ${response.statusCode}");
      return testFlights;
    }
  }
}
