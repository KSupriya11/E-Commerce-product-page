import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

// 🧩 Vaccine Model
class Vaccine {
  final String name;
  final DateTime dueDate;
  final bool isCompleted;

  Vaccine({
    required this.name,
    required this.dueDate,
    required this.isCompleted,
  });
}

// 💉 Example mock data
final List<Vaccine> sampleVaccines = [
  Vaccine(name: 'BCG', dueDate: DateTime(2025, 1, 10), isCompleted: true),
  Vaccine(
      name: 'Polio (OPV-1)', dueDate: DateTime(2025, 2, 15), isCompleted: true),
  Vaccine(name: 'DPT-1', dueDate: DateTime(2025, 10, 12), isCompleted: false),
  Vaccine(
      name: 'Hepatitis B (2nd Dose)',
      dueDate: DateTime(2025, 10, 15),
      isCompleted: false),
  Vaccine(name: 'Measles', dueDate: DateTime(2025, 11, 1), isCompleted: false),
  Vaccine(
      name: 'Vitamin A Supplement',
      dueDate: DateTime(2025, 12, 10),
      isCompleted: false),
];

class VaccinationRemindersScreen extends StatefulWidget {
  const VaccinationRemindersScreen({super.key});

  @override
  State<VaccinationRemindersScreen> createState() =>
      _VaccinationRemindersScreenState();
}

class _VaccinationRemindersScreenState
    extends State<VaccinationRemindersScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotifications(); // sets up notifications + timezone + schedules
  }

  Future<void> _initNotifications() async {
    // 1) Initialize plugin
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // 2) Configure timezone (must be done before scheduling)
    await _configureLocalTimeZone();

    // 3) Schedule notifications
    await _scheduleNotifications();
  }

  Future<void> _configureLocalTimeZone() async {
    // Load timezone database
    tz.initializeTimeZones();

    // Get device timezone and set local location
    String timeZoneName = 'UTC';
    try {
      timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      // fallback
      debugPrint('Could not get the local timezone: $e');
    }
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> _scheduleNotifications() async {
    final now = tz.TZDateTime.now(tz.local);

    for (final vaccine in sampleVaccines) {
      if (vaccine.isCompleted) continue;

      // Reminder: 2 days before due date at 9:00 AM local time
      final DateTime reminderDateTime =
          vaccine.dueDate.subtract(const Duration(days: 2));

      // build a tz.TZDateTime at 09:00 on the reminder day in local tz
      final tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        reminderDateTime.year,
        reminderDateTime.month,
        reminderDateTime.day,
        9, // hour
        0, // minute
      );

      if (scheduledDate.isBefore(now)) {
        // don't schedule past notifications
        continue;
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        vaccine.name.hashCode, // unique id for the notification
        'Vaccination Reminder',
        'Your ${vaccine.name} vaccine is due on ${vaccine.dueDate.toString().substring(0, 10)}',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'vaccine_channel',
            'Vaccination Reminders',
            channelDescription: 'Reminds patients about upcoming vaccinations',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // you may add matchDateTimeComponents if you want recurring behavior
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination Reminders'),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleVaccines.length,
        itemBuilder: (context, index) {
          final v = sampleVaccines[index];
          final isDue = v.dueDate.isBefore(today) && !v.isCompleted;

          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(
                v.isCompleted
                    ? Icons.check_circle
                    : isDue
                        ? Icons.warning_amber_rounded
                        : Icons.event_available,
                color: v.isCompleted
                    ? Colors.green
                    : isDue
                        ? Colors.redAccent
                        : Colors.orange,
                size: 32,
              ),
              title: Text(
                v.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Due: ${v.dueDate.toString().substring(0, 10)}',
                style: TextStyle(
                  color: v.isCompleted
                      ? Colors.grey
                      : isDue
                          ? Colors.red
                          : Colors.orangeAccent,
                ),
              ),
              trailing: v.isCompleted
                  ? const Text('Done', style: TextStyle(color: Colors.green))
                  : isDue
                      ? const Text('Overdue',
                          style: TextStyle(color: Colors.red))
                      : const Text('Upcoming',
                          style: TextStyle(color: Colors.orange)),
            ),
          );
        },
      ),
    );
  }
}
