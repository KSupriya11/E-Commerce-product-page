// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _userId = "";
  String _password = "";
  String _role = 'Patient'; // default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF26A69A), Color(0xFF3949AB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(
                    Icons.login_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 6,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // User ID
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.perm_identity),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSaved: (val) => _userId = val ?? '',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? 'Enter User ID' : null,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                    onSaved: (val) => _password = val ?? '',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? 'Enter password' : null,
                  ),
                  const SizedBox(height: 16),

                  // Role dropdown
                  DropdownButtonFormField<String>(
                    initialValue: _role,
                    items: ['Patient', 'ASHA', 'Doctor', 'Admin']
                        .map((role) =>
                            DropdownMenuItem(value: role, child: Text(role)))
                        .toList(),
                    onChanged: (val) => setState(() => _role = val!),
                    decoration: InputDecoration(
                      labelText: 'Select Role',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.account_box),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadowColor: Colors.black45,
                      elevation: 6,
                    ),
                    child: const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Logged in as $_role (ID: $_userId) — password: ${List.filled(_password.length, '*').join()}'),
                          ),
                        );

                        _navigateToRoleHome();
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Register link
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: const Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToRoleHome() {
    String route;
    switch (_role) {
      case 'ASHA':
        route = AppRoutes.ashaHome;
        break;
      case 'Doctor':
        route = AppRoutes.doctorHome;
        break;
      case 'Admin':
        route = AppRoutes.adminHome;
        break;
      default:
        route = AppRoutes.patientHome;
    }

    Navigator.pushReplacementNamed(context, route);
  }
}
