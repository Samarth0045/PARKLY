import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkly_app/logic/provider/auth_provider.dart';
import 'home_screen.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  _CreateNewPasswordScreenState createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // 🚀 Generate the first CAPTCHA code when the screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).generateCaptcha();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Create New Password"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://illustrations.popsy.co/white/key.svg',
                height: 180,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Create Your New Password",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildPassField(_passController, "New Password"),
            const SizedBox(height: 20),
            _buildPassField(_confirmPassController, "Confirm Password"),

            const SizedBox(height: 30),

            // 🛡️ CAPTCHA Section
            const Text(
              "Security Verification",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                // The Visual CAPTCHA Box
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F222A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF4C4DDC).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    authProvider.currentCaptcha,
                    style: const TextStyle(
                      color: Color(0xFF4C4DDC),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white70),
                  onPressed: () => authProvider.generateCaptcha(),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildCaptchaField(),

            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  activeColor: const Color(0xFF4C4DDC),
                  onChanged: (val) => setState(() => _rememberMe = val!),
                ),
                const Text(
                  "Remember me",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C4DDC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // 1. Check if passwords match
                  if (_passController.text != _confirmPassController.text) {
                    _showError("Passwords do not match");
                    return;
                  }

                  // 2. Verify CAPTCHA
                  if (authProvider.verifyCaptcha(_captchaController.text)) {
                    _showSuccessDialog(context);
                  } else {
                    _showError("Invalid CAPTCHA code");
                    authProvider.generateCaptcha(); // Refresh on fail
                    _captchaController.clear();
                  }
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        prefixIcon: const Icon(Icons.lock, color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF1F222A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCaptchaField() {
    return TextField(
      controller: _captchaController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Enter Code Above",
        hintStyle: const TextStyle(color: Colors.white38),
        prefixIcon: const Icon(
          Icons.verified_user_outlined,
          color: Colors.white38,
        ),
        filled: true,
        fillColor: const Color(0xFF1F222A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F222A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF4C4DDC),
              child: Icon(Icons.check, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 20),
            const Text(
              "Congratulations!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your password has been reset successfully.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C4DDC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                ),
                child: const Text("Go to Homepage"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
