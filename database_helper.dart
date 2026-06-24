// File: lib/db/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/patient.dart';
import '../models/visit.dart';
import '../models/alerts.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  // ---------------- Database Instance ----------------
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'pulsepoint.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Patients Table
        await db.execute('''
          CREATE TABLE patients(
            id TEXT PRIMARY KEY,
            name TEXT,
            age INTEGER,
            gender TEXT,
            symptoms TEXT, -- stored as JSON string
            lastVisit TEXT,
            notes TEXT
          )
        ''');

        // Visits Table
        await db.execute('''
          CREATE TABLE visits(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            patientId TEXT,
            date TEXT,
            notes TEXT
          )
        ''');

        // Alerts Table (AI alert, critical alert, call)
        await db.execute('''
          CREATE TABLE alerts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            patientId TEXT,
            type TEXT, -- ai_alert / critical / call
            date TEXT
          )
        ''');
      },
    );
  }

  // ---------------- Patients ----------------
  Future<void> insertPatient(Patient patient) async {
    final db = await database;
    await db.insert('patients', patient.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Patient>> getAllPatients() async {
    final db = await database;
    final maps = await db.query('patients');
    return List.generate(maps.length, (i) => Patient.fromMap(maps[i]));
  }

  /// 🔹 Fetch single patient by ID (for QR scanning)
  Future<Map<String, dynamic>?> getPatientById(String id) async {
    final db = await database;
    final res = await db.query(
      'patients',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (res.isNotEmpty) {
      return res.first;
    }
    return null;
  }

  // ---------------- Visits ----------------
  Future<void> insertVisit(Visit visit) async {
    final db = await database;
    await db.insert('visits', visit.toMap());
  }

  Future<int> getVisitsCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
            await db.rawQuery("SELECT COUNT(*) FROM visits")) ??
        0;
  }

  // ---------------- Alerts ----------------
  Future<void> insertAlert(Alert alert) async {
    final db = await database;
    await db.insert('alerts', alert.toMap());
  }

  Future<void> insertCall(String patientId) async {
    final db = await database;
    await db.insert('alerts', {
      "patientId": patientId,
      "type": "call",
      "date": DateTime.now().toIso8601String(),
    });
  }

  Future<int> getAlertsCount(String type) async {
    final db = await database;
    return Sqflite.firstIntValue(await db
            .rawQuery("SELECT COUNT(*) FROM alerts WHERE type = ?", [type])) ??
        0;
  }

  Future<int> getCallCount() async {
    final db = await database;
    return Sqflite.firstIntValue(await db
            .rawQuery("SELECT COUNT(*) FROM alerts WHERE type = 'call'")) ??
        0;
  }

  // ---------------- Stats ----------------
  Future<Map<String, int>> getTriageStats() async {
    final patients = await getAllPatients();
    int normal = 0, emergency = 0, critical = 0;

    for (var p in patients) {
      final lowerSymptoms = p.symptoms.map((s) => s.toLowerCase()).toList();
      if (lowerSymptoms.any((s) => s.contains("severe"))) {
        critical++;
      } else if (lowerSymptoms.any((s) => s.contains("moderate"))) {
        emergency++;
      } else {
        normal++;
      }
    }

    return {"normal": normal, "emergency": emergency, "critical": critical};
  }

  Future<Map<String, int>> getVisitsAndAlerts() async {
    final visits = await getVisitsCount();
    final aiAlerts = await getAlertsCount("ai_alert");
    final critical = await getAlertsCount("critical");
    final calls = await getCallCount();

    return {
      "visits": visits,
      "ai_alerts": aiAlerts,
      "critical_cases": critical,
      "calls": calls,
    };
  }
}
// ---------------- End of Database Helper ----------------
