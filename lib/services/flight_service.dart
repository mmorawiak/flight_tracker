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

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['error'] != null) {
        print("API Error: \${json['error']['message']}");
        return [];
      }

      final flightsJson = json['data'] as List<dynamic>;
      return flightsJson.map((json) => Flight.fromJson(json)).toList();
    } else {
      print("Failed to load flights: \${response.statusCode}");
      return [];
    }
  }
}
