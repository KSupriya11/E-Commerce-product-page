import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

// Import your screens
import 'ASHA_management_screen.dart';
import 'schedule_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  // -----------------------
  // Mock Data
  // -----------------------
  final List<Map<String, dynamic>> reportData = const [
    {'type': 'Weekly', 'patients': 20, 'responded': 15},
    {'type': 'Monthly', 'patients': 85, 'responded': 70},
    {'type': 'Yearly', 'patients': 1020, 'responded': 900},
  ];

  final List<Map<String, String>> alerts = [
    {'id': 'P001', 'name': 'S.Shiny', 'alert': 'High fever'},
    {'id': 'P005', 'name': 'R.S.Trisha', 'alert': 'Severe headache'},
    {'id': 'P008', 'name': 'M.Raja', 'alert': 'Low blood pressure'},
  ];

  final List<Map<String, String>> triage = [
    {'id': 'P002', 'name': 'S.Reshma', 'priority': 'High'},
    {'id': 'P004', 'name': 'K.priya', 'priority': 'Medium'},
    {'id': 'P007', 'name': 'S.lakshman', 'priority': 'High'},
  ];

  final List<Map<String, dynamic>> doctors = [
    {'name': 'Dr. Ravi Kumar', 'available': true, 'ASHA': 5},
    {'name': 'Dr. Sita Devi', 'available': true, 'ASHA': 5},
    {'name': 'Dr. Lakshmi R.', 'available': true, 'ASHA': 5},
    {'name': 'Dr. Arun Kumar', 'available': true, 'ASHA': 5},
    {'name': 'Dr. Priya Sharma', 'available': true, 'ASHA': 5},
    {'name': 'Dr. Vikram Patel', 'available': false, 'ASHA': 5},
    {'name': 'Dr. Rohan Singh', 'available': true, 'ASHA': 5},
    {'name': 'Dr. Geeta Devi', 'available': true, 'ASHA': 5},
    {'name': 'Dr. Meena Das', 'available': false, 'ASHA': 5},
    {'name': 'Dr. Manoj Singh', 'available': false, 'ASHA': 5},
  ];

  final List<Map<String, dynamic>> ashaWorkers = [
    {'name': 'S.Reshma', 'patients': 20, 'active': true},
    {'name': 'M.Rakshan', 'patients': 27, 'active': false},
    {'name': 'V.Magesh', 'patients': 21, 'active': true},
    {'name': 'S.Shiny', 'patients': 42, 'active': true},
    {'name': 'M.Ramesh', 'patients': 29, 'active': false},
    {'name': 'R.Gomathi', 'patients': 25, 'active': true},
    {'name': 'K.Asha', 'patients': 20, 'active': true},
    {'name': 'P.Latha', 'patients': 13, 'active': false},
    {'name': 'T.Selvi', 'patients': 25, 'active': true},
    {'name': 'N.Kavitha', 'patients': 20, 'active': true},
  ];

  // -----------------------
  // PDF Generation
  // -----------------------
  void _generatePdf(Map<String, dynamic> data) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('${data['type']} Report',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Total Patients: ${data['patients']}'),
              pw.Text('Patients Responded: ${data['responded']}'),
              pw.Text(
                  'Patients Pending: ${data['patients'] - data['responded']}'),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  void _generatePdfForStaff(
      String title, List<Map<String, dynamic>> data) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(title,
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              ...data.map((d) => pw.Text(
                  '${d['name']} - Patients: ${d['patients']} - ${d.containsKey('available') ? (d['available'] ? 'Available' : 'Not Available') : (d['active'] ? 'Active' : 'Inactive')}')),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // -----------------------
  // Screens for BottomNavigationBar
  // -----------------------
  List<Widget> get _screens => [
        _buildReportsScreen(),
        _buildAlertsScreen(),
        _buildTriageScreen(),
        _buildDoctorsScreen(),
        _buildASHAWorkersScreen(),
      ];

  Widget _buildReportsScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reportData.length,
      itemBuilder: (context, index) {
        final report = reportData[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text('${report['type']} Report'),
            subtitle: Text(
                'Patients: ${report['patients']}, Responded: ${report['responded']}'),
            trailing: ElevatedButton(
              onPressed: () => _generatePdf(report),
              child: const Text('Download PDF'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAlertsScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        final alert = alerts[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text(alert['name']!),
            subtitle: Text('ID: ${alert['id']} - ${alert['alert']}'),
          ),
        );
      },
    );
  }

  Widget _buildTriageScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: triage.length,
      itemBuilder: (context, index) {
        final patient = triage[index];
        Color priorityColor;
        switch (patient['priority']) {
          case 'High':
            priorityColor = Colors.red;
            break;
          case 'Medium':
            priorityColor = Colors.orange;
            break;
          default:
            priorityColor = Colors.green;
        }

        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: priorityColor,
              child: Text(patient['priority']![0],
                  style: const TextStyle(color: Colors.white)),
            ),
            title: Text(patient['name']!),
            subtitle:
                Text('ID: ${patient['id']} - Priority: ${patient['priority']}'),
          ),
        );
      },
    );
  }

  Widget _buildDoctorsScreen() {
    // Instead of building inline, navigate to ScheduleScreen
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ScheduleScreen(doctorsFrom: doctors),
            ),
          );
        },
        child: const Text('Go to Doctors Monitor'),
      ),
    );
  }

  Widget _buildASHAWorkersScreen() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ASHAWorkerManagementScreen(),
            ),
          );
        },
        child: const Text('Go to ASHA Workers Monitor'),
      ),
    );
  }

  // -----------------------
  // Scaffold with BottomNavigationBar
  // -----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Triage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'ASHA Workers',
          ),
        ],
      ),
    );
  }
}

