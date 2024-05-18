import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String description;
  final DateTime dateTime;

  AppointmentCard({
    required this.patientName,
    required this.description,
     required  this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Add a shadow for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 150, // Adjust the width as per your design
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              patientName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Appointment Time: $dateTime',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
