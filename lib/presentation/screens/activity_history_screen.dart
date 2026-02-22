import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkly_app/models/parking_session.dart'; // Add intl: ^0.19.0 to pubspec.yaml

class ActivityHistoryScreen extends StatelessWidget {
  // Mock data for your ParkAI sessions
  final List<ParkingSession> history = [
    ParkingSession(id: "1", locationName: "Zeal College Parking", date: DateTime.now(), duration: "2h 30m", cost: 50.0, isCompleted: false),
    ParkingSession(id: "2", locationName: "Pavillion Mall, Pune", date: DateTime.now().subtract(const Duration(days: 1)), duration: "1h 15m", cost: 30.0),
    ParkingSession(id: "3", locationName: "FC Road Side Parking", date: DateTime.now().subtract(const Duration(days: 2)), duration: "45m", cost: 20.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Parking History", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: history.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final item = history[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1F222A), // Matching your UI kit
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Icon based on status
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.isCompleted ? Colors.green.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.isCompleted ? Icons.check_circle_outline : Icons.timer_outlined,
                    color: item.isCompleted ? Colors.green : const Color(0xFF4C4DDC),
                  ),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.locationName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(DateFormat('dd MMM, yyyy').format(item.date), style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
                // Cost and Duration
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("₹${item.cost}", style: const TextStyle(color: Color(0xFF4C4DDC), fontWeight: FontWeight.bold)),
                    Text(item.duration, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}