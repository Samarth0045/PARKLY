import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isBiometricEnabled = false;
  bool get isBiometricEnabled => _isBiometricEnabled;

  Future<void> signup(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await _storage.write(key: 'user_name', value: name);
    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'user_password', value: password);

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    String? storedEmail = await _storage.read(key: 'user_email');
    String? storedPassword = await _storage.read(key: 'user_password');

    _isLoading = false;
    notifyListeners();

    return (email == storedEmail && password == storedPassword);
  }

  Future<void> toggleBiometric(bool value) async {
    _isBiometricEnabled = value;
    await _storage.write(key: 'use_biometrics', value: value.toString());
    notifyListeners();
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      bool canAuthenticate =
          await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();

      if (!canAuthenticate) return false;

      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed with ParkAI',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint("Biometric Error: $e");
      return false;
    }
  }

  Future<void> loadBiometricPreference() async {
    String? val = await _storage.read(key: 'use_biometrics');
    _isBiometricEnabled = (val == 'true');
    notifyListeners();
  }
}
