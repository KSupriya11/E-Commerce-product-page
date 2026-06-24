import 'package:flutter/material.dart';
import 'health_records.dart'; 
// ✅ Import your HealthRecordsScreen file
import 'connect_asha.dart';
import 'vacc_remain_screen.dart';
import 'mat_health_screen.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String userId = "PATIENT123"; // Example user ID from login page

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Patient Dashboard'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ✅ View Health Records
          ElevatedButton.icon(
            icon: const Icon(Icons.folder_shared),
            label: const Text('View My Health Records'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HealthRecordsScreen(
                    userId: userId,
                    records: sampleRecords, // ✅ from health_records_screen.dart
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // 📞 Call ASHA Worker
          ElevatedButton.icon(
            icon: const Icon(Icons.call),
            label: const Text('Call ASHA Worker (Toll-Free)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConnectScreen()),
              );
            },
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            icon: const Icon(Icons.vaccines),
            label: const Text('Vaccination Reminders'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const VaccinationRemindersScreen())
              );
            },
          ),


         ElevatedButton.icon(
  icon: const Icon(Icons.favorite),
  label: const Text('Maternal Health Support'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.pinkAccent,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    textStyle: const TextStyle(fontSize: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 3,
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MaternalHealthScreen(isMaternal: true), // or false
      ),
    );
  },
),
        ],
      ),
    );
  }
}