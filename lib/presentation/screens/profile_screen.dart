import 'package:flutter/material.dart';
import 'setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1F222A),
              child: Icon(Icons.person, size: 50, color: Colors.white24),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Samarth Sabale",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "samarth@example.com",
            style: TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 30),

          // Profile Menu Items
          _profileMenu(Icons.history, "Parking History"),
          _profileMenu(Icons.payment, "Payment Methods"),
          _profileMenu(Icons.help_outline, "Help Center"),
        ],
      ),
    );
  }

  Widget _profileMenu(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white24,
        size: 16,
      ),
      onTap: () {},
    );
  }
}
