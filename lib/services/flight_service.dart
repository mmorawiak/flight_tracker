import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flight_model.dart';

class FlightService {
  static const String _apiKey = 'd5ebe64814d88ca43dddc37de939a20d';
  static const String _baseUrl = 'http://api.aviationstack.com/v1/flights';

  static Future<Flight?> fetchFlight(String flightIata) async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey&flight_iata=$flightIata');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      if (jsonBody['data'] != null && jsonBody['data'].isNotEmpty) {
        return Flight.fromJson(jsonBody['data'][0]);
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to fetch flight data');
    }
  }
}
