

import 'package:flutter/material.dart';
import '../models/patient.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;
  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(patient.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID: ${patient.id}", style: TextStyle(fontSize: 18)),
            Text("Age: ${patient.age}", style: TextStyle(fontSize: 18)),
            Text("Gender: ${patient.gender}", style: TextStyle(fontSize: 18)),
            Text("Symptoms: ${patient.symptoms.join(', ')}"),
            Text("Last Visit: ${patient.lastVisit}"),
            Text("Notes: ${patient.notes}"),
          ],
        ),
      ),
    );
  }
}
