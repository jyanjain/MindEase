import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:vr_therapy_ipd/doctor/doc_onboarding.dart';
import 'package:vr_therapy_ipd/doctor/docdata.dart';
import 'package:vr_therapy_ipd/doctor/doctor_session.dart';
import 'package:vr_therapy_ipd/patient/features/appointment/appointment.dart';
import 'package:vr_therapy_ipd/patient/onboarding.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController specialization = TextEditingController();
  // final newAppointment = AppointmentCard(
  //         patientName: 'John Doe', // Replace with the actual patient's name
  //         description: 'Description goes here', // Replace with the patient's description
  //         dateTime: DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute),
  //       );
  // appointments.add(newAppointment);
  List<Doctor> doctors = [
    Doctor(name: 'Dr. Smith', specialization: 'Cardiologist'),
    Doctor(name: 'Dr. Johnson', specialization: 'Dermatologist'),
    Doctor(name: 'Dr. Williams', specialization: 'Gynecologist'),
  ];
  void addDoctorToProvider() {
    final doctorProvider =
        Provider.of<DoctorDataProvider>(context, listen: false);
    // Create a new doctor and add it to the list
    final newDoctor = Doctor(
      name: emailController.text,
      specialization: specialization.text,
    );
    doctorProvider.addDoctor(newDoctor);
  }

  Future<void> registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // User has been registered
      final doctorProvider =
          Provider.of<DoctorDataProvider>(context, listen: false);
      //  addDoctorToProvider();
      final newdocc = Doctor(
          name: emailController.text, specialization: specialization.text);
      doctorProvider.addDoctor(newdocc);
      for (var doctor in doctorProvider.doctors) {
        print(
            'Doctor Name: ${doctor.name}, Specialization: ${doctor.specialization}');
      }

      print("User registered: ${userCredential.user?.email}");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageD()));
    } catch (e) {
      print("Error registering user: $e");
    }
  }

  final newDoc = Doctor(
      name: 'emailController.text', specialization: 'specialization.text');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
