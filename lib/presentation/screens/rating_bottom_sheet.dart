import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkly_app/logic/provider/feedback_provider.dart';

class RatingBottomSheet extends StatefulWidget {
  final String location;
  const RatingBottomSheet({super.key, required this.location});

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  int _rating = 0;
  bool _isSubmitted = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1F222A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: _isSubmitted ? _buildSuccessView() : _buildRatingForm(),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(height: 20),
        Icon(Icons.stars_rounded, color: Color(0xFF4C4DDC), size: 100),
        SizedBox(height: 20),
        Text(
          "Thank You!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Your feedback helps the Parq community.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildRatingForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 40, height: 4, color: Colors.white10),
        const SizedBox(height: 20),
        const Text(
          "Rate Your Parking",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "How was your experience at ${widget.location}?",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white54, fontSize: 14),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: () => setState(() => _rating = index + 1),
              icon: Icon(
                index < _rating
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: index < _rating
                    ? const Color(0xFF4C4DDC)
                    : Colors.white24,
                size: 42,
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _commentController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Add a comment...",
            hintStyle: const TextStyle(color: Colors.white24),
            filled: true,
            fillColor: const Color(0xFF0F0F0F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: _rating == 0
                ? null
                : () async {
                    final provider = Provider.of<FeedbackProvider>(
                      context,
                      listen: false,
                    );
                    provider.addFeedback(
                      FeedbackModel(
                        location: widget.location,
                        rating: _rating,
                        date: "04 Mar 2026",
                        comment: _commentController.text,
                      ),
                    );
                    setState(() => _isSubmitted = true);
                    await Future.delayed(const Duration(milliseconds: 1800));
                    if (mounted) Navigator.pop(context);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4C4DDC),
              disabledBackgroundColor: Colors.white10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Submit Rating",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
