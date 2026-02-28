class ParkingOrder {
  final String location;
  final String date;
  final String duration;
  final String price;
  final bool isActive;

  ParkingOrder({
    required this.location,
    required this.date,
    required this.duration,
    required this.price,
    this.isActive = false,
  });
}
