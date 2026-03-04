import 'package:flutter/material.dart';
import 'package:parkly_app/models/parking_order.dart';
import 'rating_bottom_sheet.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  void _showReceipt(BuildContext context, ParkingOrder order) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        // renamed to dialogContext to avoid confusion
        backgroundColor: const Color(0xFF1F222A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Text(
            "Parking Receipt",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 20),
            _receiptRow("Location", order.location),
            _receiptRow("Date", order.date),
            _receiptRow("Duration", order.duration),
            const Divider(color: Colors.white10, height: 30),
            _receiptRow("Total Paid", order.price, isTotal: true),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // 1. Close the Receipt Dialog
                  Navigator.pop(dialogContext);

                  // 2. Show the "Downloading" feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Downloading PDF Receipt..."),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // 3. Trigger the Rating Page after a short delay (simulating download)
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (context.mounted) {
                      _showRatingSheet(context, order.location);
                    }
                  });
                },
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Color(0xFF4C4DDC),
                ),
                label: const Text(
                  "Download PDF",
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF4C4DDC)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 🚀 Helper to show the Rating Sheet ---
  void _showRatingSheet(BuildContext context, String location) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RatingBottomSheet(location: location),
    );
  }

  Widget _receiptRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54)),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? const Color(0xFF4C4DDC) : Colors.white,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          return _orderTile(context, order);
        },
      ),
    );
  }

  Widget _orderTile(BuildContext context, ParkingOrder order) {
    return GestureDetector(
      onTap: () => _showReceipt(context, order), // Trigger the dialog
      child: Container(
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
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
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
      ),
    );
  }
}
