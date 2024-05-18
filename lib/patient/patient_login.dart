import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_therapy_ipd/patient/onboarding.dart';
import 'package:vr_therapy_ipd/patient/register.dart';

class LoginPageP extends StatefulWidget {
  const LoginPageP({Key? key}) : super(key: key);

  @override
  _LoginPagePState createState() => _LoginPagePState();
}

class _LoginPagePState extends State<LoginPageP> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the next screen upon successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFCFCF7), // Change the background color here
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Image.asset(
                  'assets/login_photo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Change the box color here
                      border:
                          Border.all(color: Colors.black), // Add border here
                      borderRadius: BorderRadius.circular(
                          10.0), // Optional: Add border radius
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            color: Color(0xFF99A145)), // Change hint text color
                        border: InputBorder.none, // Hide default border
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Change the box color here
                      border:
                          Border.all(color: Colors.black), // Add border here
                      borderRadius: BorderRadius.circular(
                          10.0), // Optional: Add border radius
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Color(0xFF99A145)), // Change hint text color
                        border: InputBorder.none, // Hide default border
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot username or password
                      },
                      child: Text(
                        'Forgot your username or password?',
                        style: TextStyle(
                          color:
                              Color(0xFF99A145), // Change the text color here
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      final String email = _emailController.text.trim();
                      final String password = _passwordController.text.trim();
                      _signInWithEmailAndPassword(email, password);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFEBFF00)), // Change the color here
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CustomFont',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreenP(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFF2F5E5)), // Change the color here
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CustomFont',
                          fontWeight:
                              FontWeight.bold), // Change the text color here
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
