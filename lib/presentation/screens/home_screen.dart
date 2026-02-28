import 'package:flutter/material.dart';
import 'package:parkly_app/presentation/screens/order_status_screen.dart'; //
import 'home_dashboard_screen.dart'; //
import 'profile_screen.dart'; //
import 'parq_buttom_nav.dart'; //

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeDashboard(),
    const OrderStatusScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: IndexedStack(index: _selectedIndex, children: _pages),

      bottomNavigationBar: ParqBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
