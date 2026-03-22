import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkly_app/logic/provider/vehical_provider.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _plateController = TextEditingController();
  final _modelController = TextEditingController();
  final _ownerController = TextEditingController();
  final _contactController = TextEditingController();

  String _selectedType = 'Car';
  double _tiltAngle = 0.0;

  @override
  void dispose() {
    _plateController.dispose();
    _modelController.dispose();
    _ownerController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _saveVehicle() {
    if (_plateController.text.isNotEmpty &&
        _modelController.text.isNotEmpty &&
        _ownerController.text.isNotEmpty &&
        _contactController.text.isNotEmpty) {
      final provider = Provider.of<VehicalProvider>(context, listen: false);

      provider.addVehicle(
        Vehicle(
          type: _selectedType,
          name: _modelController.text,
          vehicleNumber: _plateController.text.toUpperCase(),
          ownerName: _ownerController.text,
          ownerContact: _contactController.text,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${_modelController.text} saved to your garage!"),
          backgroundColor: const Color(0xFF4C4DDC),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all owner and vehicle details."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add My Vehicle",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: _tiltAngle),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, tilt, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(tilt),
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                  child: _buildAnimatedCarVisuals(),
                ),
              ),
              const SizedBox(height: 30),
              _buildDropdownField(),
              const SizedBox(height: 15),
              _buildTextInputField(
                controller: _modelController,
                label: "Model",
                icon: Icons.directions_car,
              ),
              const SizedBox(height: 15),
              _buildTextInputField(
                controller: _plateController,
                label: "Plate Number",
                icon: Icons.tag,
                onChanged: (val) {
                  // 🚀 FIX: Update both tilt AND text live
                  setState(() {
                    _tiltAngle = val.isNotEmpty ? -0.2 : 0.0;
                  });
                },
              ),
              const SizedBox(height: 25),
              const Text(
                "Owner Details",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildTextInputField(
                controller: _ownerController,
                label: "Owner Name",
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              _buildTextInputField(
                controller: _contactController,
                label: "Contact",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveVehicle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C4DDC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Save Vehicle",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Extra space for keyboard
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedType,
          dropdownColor: const Color(0xFF1F222A),
          isExpanded: true,
          style: const TextStyle(color: Colors.white),
          items: [
            'Car',
            'Bike',
            'SUV',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => _selectedType = val!),
        ),
      ),
    );
  }

  Widget _buildAnimatedCarVisuals() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _selectedType == 'Bike' ? Icons.pedal_bike : Icons.directions_car,
            color: const Color(0xFF4C4DDC),
            size: 80,
          ),
          const SizedBox(height: 10),
          Text(
            _plateController.text.isEmpty
                ? "PLATE"
                : _plateController.text.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textCapitalization:
          TextCapitalization.characters, // Auto-uppercase for plate
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF4C4DDC)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF1F222A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
