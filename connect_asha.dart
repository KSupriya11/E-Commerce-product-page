import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  // Hotline number for doctors/admins
  final String hotlineNumber = '+911234567890'; // Replace with actual number

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect to ASHA Worker'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.call, size: 100, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text(
              'Emergency / Support Line',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              hotlineNumber,
              style: const TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.phone),
              label: const Text('Call Now', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => _makePhoneCall(hotlineNumber),
            ),
            const SizedBox(height: 20),
            const Text(
              'This hotline connects you to the ASHA WORKERassigned to your region.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
