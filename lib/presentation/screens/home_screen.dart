import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Parq tracker",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(18.5204, 73.8567),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.parkly.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: const LatLng(18.5204, 73.8567),
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  color: Color(0xFF1A237E),
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
