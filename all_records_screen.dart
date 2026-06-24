import 'package:flutter/material.dart';
import 'editing_screenofdoc.dart';

class AllRecordsScreen extends StatefulWidget {
  const AllRecordsScreen({super.key});

  @override
  State<AllRecordsScreen> createState() => _AllRecordsScreenState();
}

class _AllRecordsScreenState extends State<AllRecordsScreen> {
  final List<Map<String, dynamic>> _patients = [
    {
      'id': 'P001',
      'patient_name': 'Ravi Kumar',
      'symptom': 'Fever and cough',
      'remedy': ''
    },
    {
      'id': 'P002',
      'patient_name': 'Sita Devi',
      'symptom': 'Back pain',
      'remedy': ''
    },
    {
      'id': 'P003',
      'patient_name': 'Manoj Singh',
      'symptom': 'Headache, mild fever',
      'remedy': ''
    },
    {
      'id': 'P004',
      'patient_name': 'Lakshmi R.',
      'symptom': 'Vomiting and nausea',
      'remedy': ''
    },
    {
      'id': 'P005',
      'patient_name': 'Arun Kumar',
      'symptom': 'High blood pressure',
      'remedy': ''
    },
    {
      'id': 'P006',
      'patient_name': 'Priya Sharma',
      'symptom': 'Diabetes checkup',
      'remedy': ''
    },
    {
      'id': 'P007',
      'patient_name': 'Vikram Patel',
      'symptom': 'Sprained ankle',
      'remedy': ''
    },
    {
      'id': 'P008',
      'patient_name': 'Meena Das',
      'symptom': 'Cold and cough',
      'remedy': ''
    },
    {
      'id': 'P009',
      'patient_name': 'Rohan Singh',
      'symptom': 'Routine vaccination',
      'remedy': ''
    },
    {
      'id': 'P010',
      'patient_name': 'Geeta Devi',
      'symptom': 'Pregnancy checkup',
      'remedy': ''
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Patient Records'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: _patients.length,
          itemBuilder: (context, index) {
            final patient = _patients[index];
            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.teal[50],
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                title: Text(
                  '${patient['patient_name']} (${patient['id']})',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Symptoms: ${patient['symptom']}',
                          style: const TextStyle(fontSize: 16)),
                      if (patient['remedy'] != '')
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text('Remedy: ${patient['remedy']}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500)),
                        ),
                    ],
                  ),
                ),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Edit1ReportsScreen(patient: patient),
                    ),
                  );
                  setState(() {});
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


