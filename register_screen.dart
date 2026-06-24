 import 'package:flutter/material.dart';
import '../routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String _userId = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  String _role = 'Patient';

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
                    Icons.app_registration_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create Account',
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

                  // Full Name / Username
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Fullname',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSaved: (val) => _username = val ?? '',
                    validator: (val) =>
                        (val == null || val.isEmpty) ? 'Enter username' : null,
                  ),
                  const SizedBox(height: 16),

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

                  // Confirm Password
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                    onSaved: (val) => _confirmPassword = val ?? '',
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Confirm password';
                      if (val != _password) return 'Passwords do not match';
                      return null;
                    },
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

                  // Register button
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
                      'Register',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Registered $_role ($_username, ID: $_userId)'),
                          ),
                        );

                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Login link
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: const Text(
                      "Already have an account? Login",
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
}
