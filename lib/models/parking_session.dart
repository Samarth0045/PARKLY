class ParkingSession {
  final String id;
  final String locationName;
  final DateTime date;
  final String duration;
  final double cost;
  final bool isCompleted;

  ParkingSession({
    required this.id,
    required this.locationName,
    required this.date,
    required this.duration,
    required this.cost,
    this.isCompleted = true,
  });
}