import 'package:flutter/material.dart';

// Model for a health record
class HealthRecord {
  final String date;
  final String disease;
  final String symptoms;
  final String doctor;

  HealthRecord({
    required this.date,
    required this.disease,
    required this.symptoms,
    required this.doctor,
  });
}

// Example of fetched records from the database
final List<HealthRecord> sampleRecords = [
  HealthRecord(
    date: '2025-01-15',
    disease: 'Common Cold',
    symptoms: 'Sneezing, runny nose, mild fever',
    doctor: 'Dr. Kumar',
  ),
  HealthRecord(
    date: '2025-02-05',
    disease: 'Influenza',
    symptoms: 'High fever, cough, body aches, fatigue',
    doctor: 'Dr. Sharma',
  ),
  HealthRecord(
    date: '2025-03-10',
    disease: 'Malaria',
    symptoms: 'Fever, chills, headache, nausea',
    doctor: 'Dr. Mehta',
  ),
  HealthRecord(
    date: '2025-04-22',
    disease: 'Diabetes Type 2',
    symptoms: 'Frequent urination, excessive thirst, fatigue',
    doctor: 'Dr. Reddy',
  ),
  HealthRecord(
    date: '2025-05-18',
    disease: 'Hypertension',
    symptoms: 'Headaches, dizziness, blurred vision',
    doctor: 'Dr. Gupta',
  ),
  HealthRecord(
    date: '2025-06-30',
    disease: 'Asthma',
    symptoms: 'Shortness of breath, wheezing, chest tightness',
    doctor: 'Dr. Singh',
  ),
  HealthRecord(
    date: '2025-07-12',
    disease: 'Allergic Rhinitis',
    symptoms: 'Sneezing, itchy eyes, nasal congestion',
    doctor: 'Dr. Kapoor',
  ),
  HealthRecord(
    date: '2025-08-08',
    disease: 'Gastroenteritis',
    symptoms: 'Nausea, vomiting, diarrhea, stomach cramps',
    doctor: 'Dr. Iyer',
  ),
  HealthRecord(
    date: '2025-09-15',
    disease: 'Urinary Tract Infection',
    symptoms: 'Painful urination, frequent urination, lower abdomen pain',
    doctor: 'Dr. Menon',
  ),
  HealthRecord(
    date: '2025-10-01',
    disease: 'Migraine',
    symptoms: 'Severe headache, sensitivity to light, nausea',
    doctor: 'Dr. Rao',
  ),
];

class HealthRecordsScreen extends StatelessWidget {
  final String userId;
  final List<HealthRecord> records;

  const HealthRecordsScreen({
    super.key,
    required this.userId,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light theme
      appBar: AppBar(
        title: Text('Health Records of $userId'),
        backgroundColor: Colors.teal,
      ),
      body: records.isEmpty
          ? Center(
              child: Text(
                'No health records found for $userId.',
                style: const TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return Card(
                  color: Colors.white,
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.date,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Disease: ${record.disease}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text('Symptoms: ${record.symptoms}'),
                        const SizedBox(height: 4),
                        Text('Doctor: ${record.doctor}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

