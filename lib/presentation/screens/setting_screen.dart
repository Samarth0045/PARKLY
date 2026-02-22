import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkly_app/logic/provider/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Security",
            style: TextStyle(
              color: Color(0xFF4C4DDC),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F222A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(Icons.fingerprint, color: Colors.white70),
              title: const Text(
                "Biometric ID",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                "Use for faster login",
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
              trailing: Switch.adaptive(
                value: authProvider.isBiometricEnabled,
                activeColor: const Color(0xFF4C4DDC),
                onChanged: (bool value) async {
                  if (value) {
                    bool authenticated = await authProvider
                        .authenticateWithBiometrics();
                    if (authenticated) {
                      authProvider.toggleBiometric(true);
                    }
                  } else {
                    authProvider.toggleBiometric(false);
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 20),
          _settingsTile(Icons.notifications_none, "Notifications"),
          _settingsTile(Icons.language, "Language"),
          _settingsTile(Icons.privacy_tip_outlined, "Privacy Policy"),
        ],
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white24,
        size: 16,
      ),
    );
  }
}
