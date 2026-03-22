import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// 👈 Ensure these imports match your actual file structure
import 'package:parkly_app/logic/provider/booking_provider.dart';
import 'rating_bottom_sheet.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🚀 Reactive Logic: Listen to the BookingProvider
    final bookingProvider = Provider.of<BookingProvider>(context);
    final List<ParkingBooking> orders = bookingProvider.bookings;

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
      body: orders.isEmpty
          ? const Center(
              child: Text(
                "No parking history yet.",
                style: TextStyle(color: Colors.white38),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _orderTile(context, order);
              },
            ),
    );
  }

  // --- 🧾 Receipt Logic ---
  void _showReceipt(BuildContext context, ParkingBooking order) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Downloading PDF Receipt...")),
                  );
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

  // --- 🚀 Helper UI Widgets ---
  Widget _orderTile(BuildContext context, ParkingBooking order) {
    return GestureDetector(
      onTap: () => _showReceipt(context, order),
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
                Expanded(
                  child: Column(
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
                ),
                if (order.status == "Confirmed") // Matches your provider status
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
}
