import 'package:flutter/material.dart';
import 'package:parkly_app/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:parkly_app/logic/provider/auth_provider.dart';
import 'setting_screen.dart';
import 'notification_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = "Loading..."; //
  String _email = "Loading..."; //
  final _storage = const FlutterSecureStorage(); //

  @override
  void initState() {
    super.initState();
    _loadUserData(); //
  }

  Future<void> _loadUserData() async {
    String? name = await _storage.read(key: 'user_name'); //
    String? email = await _storage.read(key: 'user_email'); //

    if (mounted) {
      setState(() {
        _name = name ?? "Samarth Sabale"; //
        _email = email ?? "samarth@example.com"; //
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xFF4C4DDC),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: Color(0xFF1F222A),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white24,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF4C4DDC),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              _name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _email,
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _profileMenu(Icons.history, "Parking History"),
                  _profileMenu(Icons.payment, "Payment Methods"),
                  _profileMenu(Icons.directions_car, "My Vehicles"),
                  _profileMenu(Icons.notifications_none, "Notifications"),
                  _profileMenu(Icons.help_outline, "Help Center"),
                  const Divider(color: Colors.white10, height: 40),
                  _profileMenu(Icons.logout, "Logout", isLogout: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileMenu(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isLogout
              ? Colors.red.withOpacity(0.1)
              : const Color(0xFF1F222A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: isLogout ? Colors.redAccent : Colors.white70),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: isLogout
          ? null
          : const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white24,
              size: 16,
            ),
      onTap: () async {
        if (isLogout) {
          final authProvider = Provider.of<AuthProvider>(
            context,
            listen: false,
          );
          await authProvider.logout(); //

          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          }
        } else if (title == "Notifications") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationScreen()),
          );
        } else {
          debugPrint("Tapped on $title");
        }
      },
    );
  }
}
