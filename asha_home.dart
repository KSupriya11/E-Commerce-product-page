import 'package:flutter/material.dart';
import 'qr_scanner_screen.dart';
import 'record_sympton_screen.dart';
import 'patient_history_screen.dart';
import 'edit_patient_screen.dart';
import 'conferbot_screen.dart';
import 'connect_screen.dart';

class ASHAHomeScreen extends StatelessWidget {
  const ASHAHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_DashboardItem> items = [
      _DashboardItem(
        label: 'Sync Data',
        icon: Icons.cloud_upload,
        color: Colors.blue,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Syncing data...')),
          );
        },
      ),
      _DashboardItem(
        label: 'Scan QR',
        icon: Icons.qr_code_scanner,
        color: Colors.teal,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QRScanScreen()),
          );
        },
      ),
      _DashboardItem(
        label: 'Record Symptoms',
        icon: Icons.medical_services,
        color: Colors.orange,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RecordSymptomsScreen()),
          );
        },
      ),
      _DashboardItem(
        label: 'Patient History',
        icon: Icons.history,
        color: Colors.green,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PatientHistoryScreen()),
          );
        },
      ),
      _DashboardItem(
        label: 'Edit Reports',
        icon: Icons.edit_document,
        color: Colors.purple,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditReportsScreen()),
          );
        },
      ),
      _DashboardItem(
        label: 'AI Checker',
        icon: Icons.health_and_safety,
        color: Colors.indigo,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AITriageChatbot()),
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'ASHA Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return _DashboardCard(item: items[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: 180,
                height: 180,
                child: _DashboardCard(
                  item: _DashboardItem(
                    label: 'Connect',
                    icon: Icons.support_agent,
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ConnectScreen()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dashboard item model
class _DashboardItem {
  final String label;
  final IconData icon;
  final MaterialColor color;
  final VoidCallback onTap;

  _DashboardItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

// Individual card widget
class _DashboardCard extends StatefulWidget {
  final _DashboardItem item;
  const _DashboardCard({required this.item});

  @override
  State<_DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<_DashboardCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) => setState(() => _scale = 0.95);
  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
    widget.item.onTap();
  }

  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: widget.item.color.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.item.icon,
                  size: 65,
                  color: widget.item.color.shade900,
                ),
                const SizedBox(height: 14),
                Text(
                  widget.item.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: widget.item.color.shade900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
