import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecordSymptomsScreen extends StatefulWidget {
  final String? patientId;

  const RecordSymptomsScreen({super.key, this.patientId});

  @override
  State<RecordSymptomsScreen> createState() => _RecordSymptomsScreenState();
}

class _RecordSymptomsScreenState extends State<RecordSymptomsScreen> {
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) {
          setState(() {
            _symptomsController.text = val.recognizedWords;
          });
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition not available')),
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _saveSymptoms() {
    final symptoms = _symptomsController.text.trim();

    if (symptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter symptoms')),
      );
      return;
    }

    // TODO: Save to DB or backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Symptoms saved successfully')),
    );

    _symptomsController.clear();
    _notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Patient Symptoms'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Symptoms text field with mic button
            TextField(
              controller: _symptomsController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Symptoms',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: _isListening ? _stopListening : _startListening,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Notes / Observations',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveSymptoms,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
