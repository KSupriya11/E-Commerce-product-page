import 'package:flutter/material.dart';
import 'all_records_screen.dart';
import 'schedule_screen.dart';
import 'connect_asha.dart';
import 'respond_screen.dart'; // Import the new screen

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dashboard items
    final List<_DashboardItem> items = [
      _DashboardItem(
        icon: Icons.folder_copy,
        label: 'All Records',
        color: Colors.teal.shade300,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AllRecordsScreen()),
          );
        },
      ),
      _DashboardItem(
        icon: Icons.schedule,
        label: 'Schedule',
        color: Colors.teal.shade300,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ScheduleScreen()),
          );
        },
      ),
      _DashboardItem(
        icon: Icons.person_outline,
        label: 'Responded Records',
        color: Colors.teal.shade300,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RespondedRecordsScreen()),
          );
        },
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Doctor Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2EBF2), Color(0xFFE0F7FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
          child: Column(
            children: [
              // Dashboard grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children:
                      items.map((item) => _DashboardCard(item: item)).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Button: Connect ASHA Workers
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ConnectScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent.shade400,
                  foregroundColor: Colors.black87,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Connect ASHA Workers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------
// Dashboard Item Model
// -----------------------------
class _DashboardItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _DashboardItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

// -----------------------------
// Dashboard Card Widget
// -----------------------------
class _DashboardCard extends StatelessWidget {
  final _DashboardItem item;
  const _DashboardCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Card(
        elevation: 4,
        color: item.color.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, size: 48, color: Colors.black87),
              const SizedBox(height: 10),
              Text(
                item.label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
