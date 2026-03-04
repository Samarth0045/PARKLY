import 'package:flutter/material.dart';

class FeedbackModel {
  final String location;
  final int rating;
  final String date;
  final String comment;

  FeedbackModel({
    required this.location,
    required this.rating,
    required this.date,
    required this.comment,
  });
}

class FeedbackProvider with ChangeNotifier {
  // 📝 The list that stores your actual feedback
  final List<FeedbackModel> _userFeedback = [];

  List<FeedbackModel> get userFeedback => _userFeedback;

  void addFeedback(FeedbackModel feedback) {
    _userFeedback.insert(0, feedback); // Add newest at the top
    notifyListeners(); // 🔔 This tells the UI to refresh!
  }
}
