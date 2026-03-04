import 'package:latlong2/latlong.dart';

class ParkingSpot {
  final String name;
  final String address;
  final double pricePerHour;
  final double distance;
  final double rating;
  final String imageUrl;

  ParkingSpot({
    required this.name,
    required this.address,
    required this.pricePerHour,
    required this.distance,
    required this.rating,
    required this.imageUrl,
  });
}
