import 'package:flutter/material.dart';
import 'package:parkly_app/presentation/screens/filter_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Modern Search Bar
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search Parking...",
                  hintStyle: const TextStyle(color: Colors.white24),
                  prefixIcon: const Icon(Icons.search, color: Colors.white24),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune, color: Color(0xFF4C4DDC)),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const FilterBottomSheet(),
                      );
                    },
                  ),
                  fillColor: const Color(0xFF1F222A),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "Recent",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Recent Searches (Static for now, will connect to Python/SharedPrefs)
              _recentItem("Campion Cottages"),
              _recentItem("Willow Brae"),
              _recentItem("Orchard Park"),
              _recentItem("Chaucer Ridings"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recentItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const Icon(Icons.history, color: Colors.white24, size: 18),
        ],
      ),
    );
  }
}
