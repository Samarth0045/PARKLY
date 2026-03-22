import 'package:flutter/material.dart';

// 🚗 Data Model
class Vehicle {
  final String type;
  final String name;
  final String vehicleNumber;
  final String ownerName;
  final String ownerContact;

  Vehicle({
    required this.type,
    required this.name,
    required this.vehicleNumber,
    required this.ownerName,
    required this.ownerContact,
  });
}

// 🏗️ Provider Class
class VehicalProvider with ChangeNotifier {
  final List<Vehicle> _myVehicles = [];

  List<Vehicle> get vehicles => _myVehicles;

  void addVehicle(Vehicle vehicle) {
    _myVehicles.add(vehicle);
    // 🔔 CRITICAL: This updates the Navbar and Profile instantly
    notifyListeners();
  }
}
