import 'package:flutter/material.dart';
import 'package:parkly_app/logic/provider/feedback_provider.dart';
import 'package:provider/provider.dart';

class FeedbackHistoryScreen extends StatelessWidget {
  const FeedbackHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🚀 Accessing real data from your FeedbackProvider
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    final myFeedback = feedbackProvider.userFeedback;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "My Feedback",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: myFeedback.isEmpty
          ? const Center(
              child: Text(
                "You haven't left any feedback yet.",
                style: TextStyle(color: Colors.white38),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: myFeedback.length,
              itemBuilder: (context, index) {
                final feedback = myFeedback[index];
                // ✅ Pass the FeedbackModel object directly without casting to Map
                return _feedbackTile(feedback);
              },
            ),
    );
  }

  // 🛠️ Updated to accept FeedbackModel instead of Map
  Widget _feedbackTile(FeedbackModel feedback) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  feedback.location, // ✅ Dot notation for class properties
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                feedback.date,
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < feedback.rating
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: index < feedback.rating
                    ? const Color(0xFF4C4DDC)
                    : Colors.white10,
                size: 18,
              );
            }),
          ),
          // ✍️ Check if comment exists using the class property
          if (feedback.comment.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              "\"${feedback.comment}\"",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
