
import 'package:flutter/material.dart';

// Import your screens
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/asha_home.dart';
import 'screens/doctor_home.dart';
import 'screens/admin_home.dart';
import 'screens/patient_home.dart';

class AppRoutes {
  // Define constants for all routes
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String ashaHome = '/asha';
  static const String doctorHome = '/doctor';
  static const String adminHome = '/admin';
  static const String patientHome = '/patient';

  /// Centralized route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case ashaHome:
        return MaterialPageRoute(builder: (_) => const ASHAHomeScreen());
      case doctorHome:
        return MaterialPageRoute(builder: (_) => const DoctorHomeScreen());
      case adminHome:
        return MaterialPageRoute(builder: (_) => AdminDashboardScreen());
      case patientHome:
        return MaterialPageRoute(builder: (_) => const PatientHomeScreen());
      default:
        return _errorRoute(settings.name);
    }
  }

  /// Fallback route when route not found
  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Route Error")),
        body: Center(
          child: Text(
            "⚠️ No route defined for $routeName",
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
