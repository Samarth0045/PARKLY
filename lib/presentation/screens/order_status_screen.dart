import 'package:flutter/material.dart';
import 'package:parkly_app/models/parking_order.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated dynamic data for Pune locations
    final List<ParkingOrder> orders = [
      ParkingOrder(
        location: "Amanora Mall, Hadapsar",
        date: "Today, 10:30 AM",
        duration: "4 Hours",
        price: "₹60.00",
        isActive: true,
      ),
      ParkingOrder(
        location: "Phoenix Marketcity, Viman Nagar",
        date: "24 Feb 2026",
        duration: "2 Hours",
        price: "₹40.00",
      ),
      ParkingOrder(
        location: "Pavillion Mall, SB Road",
        date: "20 Feb 2026",
        duration: "3 Hours",
        price: "₹50.00",
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Parking History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _orderTile(order);
        },
      ),
    );
  }

  Widget _orderTile(ParkingOrder order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.date,
                    style: const TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
              if (order.isActive)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C4DDC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Active",
                    style: TextStyle(
                      color: Color(0xFF4C4DDC),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const Divider(color: Colors.white10, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Duration: ${order.duration}",
                style: const TextStyle(color: Colors.white54),
              ),
              Text(
                order.price,
                style: const TextStyle(
                  color: Color(0xFF4C4DDC),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
