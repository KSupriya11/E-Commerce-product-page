import 'package:flutter/material.dart';

// Sample Patient model
class Patient {
  final String id;
  final String name;
  String report;

  Patient({required this.id, required this.name, this.report = ''});
}

class EditReportsScreen extends StatefulWidget {
  const EditReportsScreen({super.key});

  @override
  State<EditReportsScreen> createState() => _EditReportsScreenState();
}

class _EditReportsScreenState extends State<EditReportsScreen> {
  // Expanded dummy patient data
  final List<Patient> patients = [
    Patient(
        id: 'P001',
        name: 'Ravi Kumar',
        report: 'Fever last week, advised rest.'),
    Patient(
        id: 'P002',
        name: 'Sita Devi',
        report: 'Back pain observed, referred to physiotherapist.'),
    Patient(
        id: 'P003',
        name: 'Manoj Singh',
        report: 'Headache & mild fever, prescribed paracetamol.'),
    Patient(
        id: 'P004',
        name: 'Lakshmi R.',
        report: 'Vomiting and nausea, hydration advised.'),
    Patient(
        id: 'P005',
        name: 'Arun Kumar',
        report: 'High blood pressure detected, monitor daily.'),
    Patient(
        id: 'P006',
        name: 'Priya Sharma',
        report: 'Diabetes checkup, medication adjusted.'),
    Patient(
        id: 'P007',
        name: 'Vikram Patel',
        report: 'Sprained ankle, advised rest and ice pack.'),
    Patient(
        id: 'P008',
        name: 'Meena Das',
        report: 'Mild cold and cough, vitamin C prescribed.'),
    Patient(
        id: 'P009', name: 'Rohan Singh', report: 'Routine vaccination done.'),
    Patient(
        id: 'P010',
        name: 'Geeta Devi',
        report: 'Pregnancy checkup, advised folic acid supplement.'),
  ];

  // Controller for report input
  final TextEditingController _reportController = TextEditingController();

  void _editReport(Patient patient) {
    _reportController.text = patient.report;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Report for ${patient.name}'),
        content: TextField(
          controller: _reportController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Enter or update report...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                patient.report = _reportController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Report updated for ${patient.name}')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addNewReport() {
    _reportController.clear();
    String patientName = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Patient Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Patient Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => patientName = value,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reportController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter report details...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (patientName.isNotEmpty && _reportController.text.isNotEmpty) {
                setState(() {
                  patients.add(Patient(
                    id: 'P${patients.length + 1}'.padLeft(3, '0'),
                    name: patientName,
                    report: _reportController.text,
                  ));
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('New report added for $patientName')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Patient Reports'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewReport,
            tooltip: 'Add New Report',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text(
                patient.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(patient.report),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.purple),
                onPressed: () => _editReport(patient),
              ),
            ),
          );
        },
      ),
    );
  }
}
