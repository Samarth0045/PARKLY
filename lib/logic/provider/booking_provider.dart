import 'package:flutter/material.dart';

class ParkingBooking {
  final String location;
  final String date;
  final String duration;
  final String price;
  final String status;

  ParkingBooking({
    required this.location,
    required this.date,
    required this.duration,
    required this.price,
    required this.status,
  });
}

class BookingProvider with ChangeNotifier {
  final List<ParkingBooking> _bookings = [];

  List<ParkingBooking> get bookings => _bookings;

  void addBooking(ParkingBooking booking) {
    _bookings.insert(0, booking);
    notifyListeners();
  }
}
