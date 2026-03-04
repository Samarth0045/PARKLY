import 'package:flutter/material.dart';

class MyReceiptsScreen extends StatelessWidget {
  const MyReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, this list would come from local storage or your Python backend
    final List<Map<String, String>> savedReceipts = [
      {
        "name": "Amanora_Mall_March_04.pdf",
        "date": "04 Mar 2026",
        "size": "1.2 MB",
      },
      {
        "name": "Phoenix_Marketcity_Feb_24.pdf",
        "date": "24 Feb 2026",
        "size": "0.8 MB",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("My Receipts", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: savedReceipts.isEmpty
          ? _emptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: savedReceipts.length,
              itemBuilder: (context, index) {
                final receipt = savedReceipts[index];
                return _receiptFileTile(receipt);
              },
            ),
    );
  }

  Widget _receiptFileTile(Map<String, String> receipt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Color(0xFF4C4DDC), size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  receipt['name']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${receipt['date']} • ${receipt['size']}",
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.open_in_new, color: Colors.white54),
            onPressed: () {
              // Trigger the 'open_file_plus' logic here
            },
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Text(
        "No receipts saved yet.",
        style: TextStyle(color: Colors.white38),
      ),
    );
  }
}
