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
      selectedItemColor: const Color(0xFF4C4DDC),
      unselectedItemColor: Colors.white24,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_rounded),
          label: "Orders",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: "Profile",
        ),
      ],
    );
  }
}
