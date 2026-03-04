import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkly_app/logic/provider/booking_provider.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String locationName;
  final String pricePerHour;

  const BookingDetailsScreen({
    super.key,
    required this.locationName,
    required this.pricePerHour,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  int _selectedHours = 1;
  late double _basePrice;

  @override
  void initState() {
    super.initState();
    // Safely parse the price for Pune locations like Amanora
    _basePrice =
        double.tryParse(
          widget.pricePerHour.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        40.0;
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F222A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Booking Successful!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your slot at ${widget.locationName} is reserved.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C4DDC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Go to Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = _selectedHours * _basePrice;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Confirm Booking",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Location Info Card
            _infoCard(Icons.location_on, "Location", widget.locationName),
            const SizedBox(height: 20),

            // Duration Selection Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                int hr = index + 1;
                return ChoiceChip(
                  label: Text("$hr hr"),
                  selected: _selectedHours == hr,
                  onSelected: (val) => setState(() => _selectedHours = hr),
                );
              }),
            ),

            const Spacer(),

            // Booking Summary
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1F222A),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  _priceRow("Duration", "$_selectedHours Hours"),
                  _priceRow(
                    "Total",
                    "₹${totalAmount.toStringAsFixed(0)}",
                    isTotal: true,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        try {
                          final provider = Provider.of<BookingProvider>(
                            context,
                            listen: false,
                          );
                          provider.addBooking(
                            ParkingBooking(
                              location: widget.locationName,
                              date: "05 Mar 2026",
                              duration: "$_selectedHours Hours",
                              price: "₹${totalAmount.toStringAsFixed(0)}",
                              status: "Confirmed",
                            ),
                          );
                          _showSuccessDialog(context);
                        } catch (e) {
                          debugPrint("Booking Error: $e");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C4DDC),
                      ),
                      child: const Text(
                        "Confirm Booking",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4C4DDC)),
          const SizedBox(width: 20),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54)),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? const Color(0xFF4C4DDC) : Colors.white,
            fontSize: isTotal ? 20 : 14,
          ),
        ),
      ],
    );
  }
}
