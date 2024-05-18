import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/design/appointmentcard.dart';

class AppointmentCheck extends StatefulWidget {
  const AppointmentCheck({super.key});

  @override
  State<AppointmentCheck> createState() => _AppointmentCheckState();
}

class _AppointmentCheckState extends State<AppointmentCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7EBE1),
      body: Column(
        children: [
          AppointmentCard(
              patientName: 'Dhruv',
              description: 'Height Phobia',
              dateTime: DateTime.now())
        ],
      ),
    );
  }
}
