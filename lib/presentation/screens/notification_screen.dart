import 'package:flutter/material.dart';
import 'package:parkly_app/models/notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ParqNotification> todayNotifications = [
      ParqNotification(
        title: "Payment Successful!",
        location: "Amanora Mall, Pune",
        amount: "₹60.00",
        status: "Success",
        date: DateTime.now(),
      ),
      ParqNotification(
        title: "Booking Canceled",
        location: "Phoenix Marketcity",
        amount: "₹40.00",
        status: "Canceled",
        date: DateTime.now(),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            "Today",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...todayNotifications.map((notif) => _dynamicNotifTile(notif)),

          const SizedBox(height: 24),
          const Text(
            "Earlier",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _securityTile(
            "2-step verification successful",
            Icons.lock,
            Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _dynamicNotifTile(ParqNotification notif) {
    bool isSuccess = notif.status == "Success";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (isSuccess ? Colors.green : Colors.redAccent).withOpacity(
              0.1,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isSuccess ? Icons.check_circle : Icons.cancel,
            color: isSuccess ? Colors.green : Colors.redAccent,
            size: 24,
          ),
        ),
        title: Text(
          notif.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            isSuccess
                ? "Paid ${notif.amount} for parking at ${notif.location}"
                : "Booking at ${notif.location} was canceled. ${notif.amount} refunded.",
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _securityTile(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
