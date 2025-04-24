const iataCityMap = {
  'WAW': 'Warsaw',
  'WRO': 'Wroclaw',
  'KRK': 'Krakow',
  'POZ': 'Poznan',
  'GDN': 'Gdansk',
  'FRA': 'Frankfurt',
  'CDG': 'Paris',
  'JFK': 'New York',
  'LHR': 'London',
  'ADB': 'Izmir',
  'AMS': 'Amsterdam',
  'ARN': 'Stockholm',
  'OSL': 'Oslo',
  'CPH': 'Copenhagen',
  'RIX': 'Riga',
  'VIE': 'Vienna',
  'ZRH': 'Zurich',
  'BRU': 'Brussels',
  'DUB': 'Dublin',
  'MUC': 'Munich',
  'BER': 'Berlin',
  'BCN': 'Barcelona',
  'MAD': 'Madrid',
  'LIS': 'Lisbon',
  'ATH': 'Athens',
  'HEL': 'Helsinki',
  'PRG': 'Prague',
  'BUD': 'Budapest',
  'SOF': 'Sofia',
  'OTP': 'Bucharest',
  'LED': 'Saint Petersburg',
  'SVO': 'Moscow',
  'DXB': 'Dubai',
  'DOH': 'Doha',
  'IST': 'Istanbul',
  'TLV': 'Tel Aviv',
  'CAI': 'Cairo',
  'NRT': 'Tokyo',
  'HND': 'Tokyo Haneda',
  'PEK': 'Beijing',
  'PVG': 'Shanghai',
  'ICN': 'Seoul',
  'SIN': 'Singapore',
  'SYD': 'Sydney',
  'MEL': 'Melbourne',
  'YVR': 'Vancouver',
  'YYZ': 'Toronto',
  'ORD': 'Chicago',
  'ATL': 'Atlanta',
  'LAX': 'Los Angeles',
  'SFO': 'San Francisco',
  'MIA': 'Miami',
  'BOS': 'Boston',
  'SEA': 'Seattle',
  'DEN': 'Denver',
  'PHX': 'Phoenix',
  'LAS': 'Las Vegas',
};

class Flight {
  final String flightNumber;
  final String airlineName;
  final String departureAirport;
  final String arrivalAirport;
  final String status;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String departureCity;
  final String arrivalCity;
  final String flightDate;
  final double? departureLatitude;
  final double? departureLongitude;
  final double? arrivalLatitude;
  final double? arrivalLongitude;

  Flight({
    required this.flightNumber,
    required this.airlineName,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.status,
    this.departureTime,
    this.arrivalTime,
    required this.departureCity,
    required this.arrivalCity,
    required this.flightDate,
    this.departureLatitude,
    this.departureLongitude,
    this.arrivalLatitude,
    this.arrivalLongitude,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    final departureIata = json['departure']?['iata'];
    final arrivalIata = json['arrival']?['iata'];

    return Flight(
      flightNumber: json['flight']?['iata'] ?? 'N/A',
      airlineName: json['airline']?['name'] ?? 'Unknown',
      departureAirport: json['departure']?['airport'] ?? 'Unknown',
      arrivalAirport: json['arrival']?['airport'] ?? 'Unknown',
      status: json['flight_status'] ?? 'N/A',
      departureTime: DateTime.tryParse(json['departure']?['scheduled'] ?? ''),
      arrivalTime: DateTime.tryParse(json['arrival']?['scheduled'] ?? ''),
      departureCity: iataCityMap[departureIata] ?? departureIata ?? '',
      arrivalCity: iataCityMap[arrivalIata] ?? arrivalIata ?? '',
      flightDate: json['flight_date'] ?? '',
      departureLatitude: (json['departure']?['latitude'] as num?)?.toDouble(),
      departureLongitude: (json['departure']?['longitude'] as num?)?.toDouble(),
      arrivalLatitude: (json['arrival']?['latitude'] as num?)?.toDouble(),
      arrivalLongitude: (json['arrival']?['longitude'] as num?)?.toDouble(),
    );
  }

  String get formattedDepartureTime =>
      departureTime != null ? '${departureTime!.hour.toString().padLeft(2, '0')}:${departureTime!.minute.toString().padLeft(2, '0')}' : '-';

  String get formattedArrivalTime =>
      arrivalTime != null ? '${arrivalTime!.hour.toString().padLeft(2, '0')}:${arrivalTime!.minute.toString().padLeft(2, '0')}' : '-';
}
