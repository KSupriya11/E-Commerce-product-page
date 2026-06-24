import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../db/database_helper.dart';
import '../models/patient.dart';
import 'patient_detail_screen.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan Patient QR")),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController ctrl) {
    controller = ctrl;
    controller.scannedDataStream.listen((scanData) async {
      final patientId = scanData.code;

      // Fetch patient from DB
      final patientMap = await DatabaseHelper().getPatientById(patientId!);

      if (patientMap != null) {
        // Convert map to Patient model
        final patient = Patient.fromMap(patientMap);

        // Navigate to detail screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PatientDetailScreen(patient: patient),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No patient found for ID: $patientId")),
        );
        controller.resumeCamera();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
