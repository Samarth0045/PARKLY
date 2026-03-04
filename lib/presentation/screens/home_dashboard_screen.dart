import 'package:flutter/material.dart';
import 'package:parkly_app/presentation/screens/booking_detailed_screen.dart';
import 'search_screen.dart';

class ParkingSpot {
  final String name;
  final String address;
  final String price;
  final String distance;
  final double rating;

  ParkingSpot({
    required this.name,
    required this.address,
    required this.price,
    required this.distance,
    required this.rating,
  });
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ParkingSpot> nearbySpots = [
      ParkingSpot(
        name: "Amanora Mall Parking",
        address: "Hadapsar, Pune",
        price: "₹40/hr",
        distance: "1.2 km",
        rating: 4.8,
      ),
      ParkingSpot(
        name: "Phoenix Marketcity",
        address: "Viman Nagar, Pune",
        price: "₹60/hr",
        distance: "3.5 km",
        rating: 4.5,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Samarth 👋",
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                      Text(
                        "Find Your Spot",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF1F222A),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- Search Bar ---
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F222A),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.white24),
                      SizedBox(width: 12),
                      Text(
                        "Search Parking, Malls, or Areas...",
                        style: TextStyle(color: Colors.white24, fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.tune, color: Color(0xFF4C4DDC)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- Quick Actions ---
              const Text(
                "Quick Search",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickAction(Icons.local_mall, "Malls"),
                  _quickAction(Icons.local_hospital, "Hospitals"),
                  _quickAction(Icons.work, "Offices"),
                  _quickAction(Icons.more_horiz, "More"),
                ],
              ),
              const SizedBox(height: 30),

              // --- Nearby Parking ---
              const Text(
                "Nearby Parking",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: nearbySpots.length,
                itemBuilder: (context, index) {
                  return _bookingCard(context, nearbySpots[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookingCard(BuildContext context, ParkingSpot spot) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F0F),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.local_parking,
              color: Color(0xFF4C4DDC),
              size: 35,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spot.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  spot.address,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    Text(
                      " ${spot.rating} • ${spot.distance}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                spot.price,
                style: const TextStyle(
                  color: Color(0xFF4C4DDC),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // 🚀 NAVIGATE TO BOOKING DETAILS
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailsScreen(
                        locationName: spot.name,
                        pricePerHour: spot.price,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C4DDC),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Book",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFF1F222A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF4C4DDC)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}
