import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class FlightMapScreen extends StatelessWidget {
  final double departureLatitude;
  final double departureLongitude;
  final double arrivalLatitude;
  final double arrivalLongitude;

  const FlightMapScreen({
    super.key,
    required this.departureLatitude,
    required this.departureLongitude,
    required this.arrivalLatitude,
    required this.arrivalLongitude,
  });

  @override
  Widget build(BuildContext context) {
    final LatLng departure = LatLng(departureLatitude, departureLongitude);
    final LatLng arrival = LatLng(arrivalLatitude, arrivalLongitude);
    final curvedPath = _generateCurvedPath(departure, arrival);

    return Scaffold(
      appBar: AppBar(title: Text('Flight Route')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: departure,
          zoom: 5,
        ),
        markers: {
          Marker(
            markerId: MarkerId('departure'),
            position: departure,
            infoWindow: InfoWindow(title: 'Departure'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
          Marker(
            markerId: MarkerId('arrival'),
            position: arrival,
            infoWindow: InfoWindow(title: 'Arrival'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('flight_path'),
            points: curvedPath,
            color: Colors.redAccent,
            width: 4,
          ),
        },
      ),
    );
  }

  List<LatLng> _generateCurvedPath(LatLng from, LatLng to, {int segments = 80}) {
    final List<LatLng> path = [];
    final lat1 = from.latitude * pi / 180;
    final lon1 = from.longitude * pi / 180;
    final lat2 = to.latitude * pi / 180;
    final lon2 = to.longitude * pi / 180;

    for (int i = 0; i <= segments; i++) {
      final f = i / segments;
      final A = sin((1 - f) * _centralAngle(lat1, lon1, lat2, lon2)) / sin(_centralAngle(lat1, lon1, lat2, lon2));
      final B = sin(f * _centralAngle(lat1, lon1, lat2, lon2)) / sin(_centralAngle(lat1, lon1, lat2, lon2));

      final x = A * cos(lat1) * cos(lon1) + B * cos(lat2) * cos(lon2);
      final y = A * cos(lat1) * sin(lon1) + B * cos(lat2) * sin(lon2);
      final z = A * sin(lat1) + B * sin(lat2);

      final lat = atan2(z, sqrt(x * x + y * y));
      final lon = atan2(y, x);

      path.add(LatLng(lat * 180 / pi, lon * 180 / pi));
    }

    return path;
  }

  double _centralAngle(double lat1, double lon1, double lat2, double lon2) {
    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;
    final a = pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
    return 2 * asin(sqrt(a));
  }
}
