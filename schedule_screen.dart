import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  final List<Map<String, dynamic>>? doctorsFrom;

  const ScheduleScreen({super.key, this.doctorsFrom});

  // Default mock doctors list
  final List<Map<String, dynamic>> defaultDoctors = const [
    {'name': 'Dr. Ravi Kumar', 'available': true},
    {'name': 'Dr. Sita Devi', 'available': true},
    {'name': 'Dr. Manoj Singh', 'available': false},
    {'name': 'Dr. Lakshmi R.', 'available': true},
    {'name': 'Dr. Arun Kumar', 'available': true},
    {'name': 'Dr. Priya Sharma', 'available': true},
    {'name': 'Dr. Vikram Patel', 'available': false},
    {'name': 'Dr. Meena Das', 'available': false},
    {'name': 'Dr. Rohan Singh', 'available': true},
    {'name': 'Dr. Geeta Devi', 'available': true},
  ];

  // Mock ASHA workers list (5 per doctor)
  final Map<String, List<String>> ashaWorkers = const {
    'Dr. Ravi Kumar': [
      'Anita Raj',
      'Sunita Sharma',
      'Rekha Nair',
      'Neha Kapoor',
      'Pooja Verma'
    ],
    'Dr. Sita Devi': [
      'Kavita Singh',
      'Manisha Patel',
      'Deepa Joshi',
      'Swati Rao',
      'Shalini Mehta'
    ],
    'Dr. Manoj Singh': [
      'Priya Yadav',
      'Seema Chauhan',
      'Aarti Sinha',
      'Rina Das',
      'Megha Rathi'
    ],
    'Dr. Lakshmi R.': [
      'Anjali R.',
      'Preeti K.',
      'Shweta L.',
      'Divya T.',
      'Nisha P.'
    ],
    'Dr. Arun Kumar': [
      'Ritu S.',
      'Neha G.',
      'Kiran M.',
      'Sonal B.',
      'Reema J.'
    ],
    'Dr. Priya Sharma': [
      'Asha V.',
      'Komal R.',
      'Poonam K.',
      'Rakhi S.',
      'Nandita D.'
    ],
    'Dr. Vikram Patel': [
      'Bhavna L.',
      'Chitra P.',
      'Rina S.',
      'Anju M.',
      'Sangeeta C.'
    ],
    'Dr. Meena Das': [
      'Geeta N.',
      'Radha S.',
      'Pallavi T.',
      'Nisha K.',
      'Lata R.'
    ],
    'Dr. Rohan Singh': [
      'Priya B.',
      'Sunita V.',
      'Aarti K.',
      'Divya P.',
      'Rekha J.'
    ],
    'Dr. Geeta Devi': [
      'Rina M.',
      'Kiran P.',
      'Seema T.',
      'Anjali V.',
      'Swati N.'
    ],
  };

  @override
  Widget build(BuildContext context) {
    // ✅ Fix: Use the doctors list passed from admin, else use default
    final doctors = doctorsFrom ?? defaultDoctors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Schedule'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          final isAvailable = doctor['available'] as bool;

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isAvailable ? Colors.green : Colors.red,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                doctor['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                isAvailable ? 'Available' : 'Not Available',
                style: TextStyle(
                  color: isAvailable ? Colors.green : Colors.red,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                if (isAvailable) {
                  final assignedWorkers =
                      ashaWorkers[doctor['name']] ?? ['No ASHA workers'];
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('ASHA Workers assigned to ${doctor['name']}'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: assignedWorkers
                            .map((worker) => ListTile(
                                  leading: const Icon(Icons.person),
                                  title: Text(worker),
                                ))
                            .toList(),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                } else {
                  final nextDoctor = doctors.firstWhere(
                    (d) => d['available'] == true,
                    orElse: () => {'name': 'No available doctor'},
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${doctor['name']} is not available. Connect to ${nextDoctor['name']} instead.'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
