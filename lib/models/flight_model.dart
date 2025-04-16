class Flight {
  final String flightNumber;
  final String airlineName;
  final String status;
  final String departureAirport;
  final String departureTime;
  final String arrivalAirport;
  final String arrivalTime;

  Flight({
    required this.flightNumber,
    required this.airlineName,
    required this.status,
    required this.departureAirport,
    required this.departureTime,
    required this.arrivalAirport,
    required this.arrivalTime,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightNumber: json['flight']?['iata'] ?? 'N/A',
      airlineName: json['airline']?['name'] ?? 'N/A',
      status: json['flight_status'] ?? 'N/A',
      departureAirport: json['departure']?['airport'] ?? 'Unknown',
      departureTime: json['departure']?['scheduled'] ?? 'Unknown',
      arrivalAirport: json['arrival']?['airport'] ?? 'Unknown',
      arrivalTime: json['arrival']?['scheduled'] ?? 'Unknown',
    );
  }
}
