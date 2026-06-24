import 'package:flutter/material.dart';
import 'routes.dart'; // Import your routes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse Point',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),

      // Use centralized route generator
      onGenerateRoute: AppRoutes.generateRoute,

      // Default route
      initialRoute: AppRoutes.home,
    );
  }
}


