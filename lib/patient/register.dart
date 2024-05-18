import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_therapy_ipd/patient/onboarding.dart';

class RegistrationScreenP extends StatefulWidget {
  @override
  _RegistrationScreenPState createState() => _RegistrationScreenPState();
}

class _RegistrationScreenPState extends State<RegistrationScreenP> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // User has been registered
      print("User registered: ${userCredential.user?.email}");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print("Error registering user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      backgroundColor: Color(0xFFFCFCF7), // Change the background color here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white, // Change the box color here
                border: Border.all(color: Colors.black), // Add border here
                borderRadius:
                    BorderRadius.circular(10.0), // Optional: Add border radius
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color(0xFF99A145), // Change hint text color
                    fontFamily: 'CustomFont', // Apply custom font
                  ),
                  border: InputBorder.none, // Hide default border
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white, // Change the box color here
                border: Border.all(color: Colors.black), // Add border here
                borderRadius:
                    BorderRadius.circular(10.0), // Optional: Add border radius
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFF99A145), // Change hint text color
                    fontFamily: 'CustomFont', // Apply custom font
                  ),
                  border: InputBorder.none, // Hide default border
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFFEBFF00)), // Change the button color here
              ),
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CustomFont', // Apply custom font
                    fontWeight: FontWeight.bold), // Apply font weight
              ),
            ),
          ],
        ),
      ),
    );
  }
}
