import 'package:flutter/material.dart';
import 'editing_screenofdoc.dart'; // EditReportsScreen for editing remedy

class RespondedRecordsScreen extends StatefulWidget {
  const RespondedRecordsScreen({super.key});

  @override
  State<RespondedRecordsScreen> createState() => _RespondedRecordsScreenState();
}

class _RespondedRecordsScreenState extends State<RespondedRecordsScreen> {
  // Mock patient data
  final List<Map<String, dynamic>> patients = List.generate(10, (index) {
    return {
      'id': 'P${(index + 1).toString().padLeft(3, '0')}',
      'name': 'Patient ${(index + 1)}',
      'symptom': 'Symptom ${(index + 1)}',
      'remedy': '',
      'responded': false,
    };
  });

  void _editPatient(int index) async {
    final patient = patients[index];

    // Open edit screen to add/edit remedy
    final updatedRemedy = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Edit1ReportsScreen(patient: patient),
      ),
    );

    if (updatedRemedy != null && updatedRemedy.isNotEmpty) {
      setState(() {
        patients[index]['remedy'] = updatedRemedy;
        patients[index]['responded'] = true; // Automatically toggle ON
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responded Records'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient name
                  Text(
                    patient['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),

                  // Symptom
                  Text('Symptom: ${patient['symptom']}'),

                  // Remedy (only if available)
                  if (patient['remedy'].isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text('Remedy: ${patient['remedy']}',
                        style: const TextStyle(color: Colors.green)),
                  ],

                  // Bottom row: Toggle + Edit button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Responded toggle (read-only)
                      Switch(
                        value: patient['responded'],
                        onChanged: null,
                        activeColor: Colors.green,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.teal),
                        onPressed: () => _editPatient(index),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
