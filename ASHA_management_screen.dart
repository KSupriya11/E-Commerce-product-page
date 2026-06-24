import 'package:flutter/material.dart';

class ASHAWorkerManagementScreen extends StatefulWidget {
  const ASHAWorkerManagementScreen({super.key});

  @override
  State<ASHAWorkerManagementScreen> createState() =>
      _ASHAWorkerManagementScreenState();
}

class _ASHAWorkerManagementScreenState
    extends State<ASHAWorkerManagementScreen> {
  // Mock data
  final List<Map<String, dynamic>> doctors = const [
    {'name': 'Dr. Ravi Kumar'},
    {'name': 'Dr. Sita Devi'},
    {'name': 'Dr. Manoj Singh'},
    {'name': 'Dr. Lakshmi R.'},
  ];

  List<Map<String, dynamic>> ashaWorkers = List.generate(10, (index) {
    return {
      'id': 'A${(index + 1).toString().padLeft(3, '0')}',
      'name': 'ASHA Worker ${(index + 1)}',
      'area': 'Area ${(index + 1)}',
      'doctor': 'Dr. Ravi Kumar',
      'status': true, // active
    };
  });

  void _editWorker(int index) {
    String newArea = ashaWorkers[index]['area'] as String;
    String newDoctor = ashaWorkers[index]['doctor'] as String;
    bool status = ashaWorkers[index]['status'] as bool;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${ashaWorkers[index]['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Area'),
              controller: TextEditingController(text: newArea),
              onChanged: (value) => newArea = value,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: newDoctor,
              items: doctors
                  .map((doc) => DropdownMenuItem<String>(
                        value: doc['name'] as String,
                        child: Text(doc['name'] as String),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) newDoctor = value;
              },
              decoration: const InputDecoration(labelText: 'Assign Doctor'),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Active'),
              value: status,
              onChanged: (val) => setState(() => status = val),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                ashaWorkers[index]['area'] = newArea;
                ashaWorkers[index]['doctor'] = newDoctor;
                ashaWorkers[index]['status'] = status;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addWorker() {
    String name = '';
    String area = '';
    String doctor = doctors.first['name'] as String;
    bool status = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add ASHA Worker'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (val) => name = val,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Area'),
              onChanged: (val) => area = val,
            ),
            DropdownButtonFormField<String>(
              initialValue: doctor,
              items: doctors
                  .map((doc) => DropdownMenuItem<String>(
                        value: doc['name'] as String,
                        child: Text(doc['name'] as String),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) doctor = val;
              },
              decoration: const InputDecoration(labelText: 'Assign Doctor'),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Active'),
              value: status,
              onChanged: (val) => setState(() => status = val),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty && area.isNotEmpty) {
                setState(() {
                  ashaWorkers.add({
                    'id':
                        'A${(ashaWorkers.length + 1).toString().padLeft(3, '0')}',
                    'name': name,
                    'area': area,
                    'doctor': doctor,
                    'status': status,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASHA Workers Management'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ashaWorkers.length,
        itemBuilder: (context, index) {
          final worker = ashaWorkers[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(worker['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${worker['id']}'),
                  Text('Area: ${worker['area']}'),
                  Text('Doctor: ${worker['doctor']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: worker['status'] as bool,
                    onChanged: (val) {
                      setState(() {
                        ashaWorkers[index]['status'] = val;
                      });
                    },
                    activeThumbColor: Colors.green,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.teal),
                    onPressed: () => _editWorker(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorker,
        backgroundColor: Colors.teal,
        tooltip: 'Add New ASHA Worker',
        child: const Icon(Icons.add),
      ),
    );
  }
}
