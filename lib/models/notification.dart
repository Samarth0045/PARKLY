class ParqNotification {
  final String title;
  final String location;
  final String amount;
  final String status; // 'Success', 'Canceled', 'Pending'
  final DateTime date;

  ParqNotification({
    required this.title,
    required this.location,
    required this.amount,
    required this.status,
    required this.date,
  });
}
