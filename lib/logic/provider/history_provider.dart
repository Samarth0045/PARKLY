import 'package:flutter/material.dart';

class ParkingOrder {
  final String location;
  final String date;
  final String duration;
  final String price;
  final String status;

  ParkingOrder({
    required this.location,
    required this.date,
    required this.duration,
    required this.price,
    required this.status,
  });
}

class HistoryProvider with ChangeNotifier {
  final List<ParkingOrder> _orders = [];
  List<ParkingOrder> get orders => _orders;

  void addOrder(ParkingOrder order) {
    _orders.insert(0, order);
    notifyListeners();
  }
}
