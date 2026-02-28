import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  String _currentCaptcha = "";
  String get currentCaptcha => _currentCaptcha;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isBiometricEnabled = false;
  bool get isBiometricEnabled => _isBiometricEnabled;

  AuthProvider() {
    _loadBiometricSetting();
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    _isLoading = true;
    notifyListeners();

    await _storage.write(key: 'user_name', value: name);
    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'user_password', value: password);
    await _storage.write(key: 'user_phone_number', value: phone);

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

    if (storedEmail == null) {
      debugPrint("No account exists on this device yet.");
      return false;
    }

    return (email == storedEmail && password == storedPassword);
  }

  Future<void> toggleBiometric(bool value) async {
    _isBiometricEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_enabled', value);
    notifyListeners();
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      final bool canCheck = await _localAuth.canCheckBiometrics;
      final bool isSupported = await _localAuth.isDeviceSupported();

      if (!canCheck || !isSupported) {
        print("Biometrics not supported on this device or not enrolled.");
        return false;
      }

      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed with Parq',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("Biometric Error: $e");
      return false;
    }
  }

  Future<void> loadBiometricPreference() async {
    String? val = await _storage.read(key: 'use_biometrics');
    _isBiometricEnabled = (val == 'true');
    notifyListeners();
  }

  void generateCaptcha() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ0123456789';
    Random rnd = Random();

    _currentCaptcha = String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
    notifyListeners();
  }

  bool verifyCaptcha(String input) {
    return input.trim().toUpperCase() == _currentCaptcha;
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _storage.write(key: 'is_logged_in', value: 'false');

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadBiometricSetting() async {
    final prefs = await SharedPreferences.getInstance();
    _isBiometricEnabled = prefs.getBool('biometric_enabled') ?? false;
    notifyListeners();
  }
}
