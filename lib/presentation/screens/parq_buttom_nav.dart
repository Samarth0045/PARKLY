import 'package:flutter/material.dart';

class ParqBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const ParqBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      backgroundColor: const Color(0xFF1F222A),
      selectedItemColor: const Color(0xFF4C4DDC), // Brand Blue
      unselectedItemColor: Colors.white24,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels:
          true, // Set to true to help users identify the new tab
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
        // 🚗 NEW: Dedicated Vehicle Tab
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car_filled_rounded),
          label: "Vehicle",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_rounded),
          label: "Booking", // Renamed for clarity with your Parking History
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: "Profile",
        ),
      ],
    );
  }
}
