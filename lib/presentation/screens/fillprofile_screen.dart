import 'package:flutter/material.dart';
import 'home_screen.dart';

class FillProfileScreen extends StatelessWidget {
  const FillProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Fill Your Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFF1F222A),
                child: Icon(Icons.person, size: 80, color: Colors.white24),
              ),
            ),
            const SizedBox(height: 30),
            _profileField("Full Name"),
            const SizedBox(height: 20),
            _profileField("Nickname"),
            const SizedBox(height: 20),
            _profileField("Phone Number", icon: Icons.phone),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // FINAL NAVIGATION: Go to Home Map
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) =>
                        false, // This clears the login history so they can't go back
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C4DDC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileField(String hint, {IconData? icon}) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        suffixIcon: icon != null ? Icon(icon, color: Colors.white38) : null,
        filled: true,
        fillColor: const Color(0xFF1F222A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
