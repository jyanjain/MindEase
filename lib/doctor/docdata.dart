import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/patient/features/appointment/appointment.dart';

class DoctorDataProvider extends ChangeNotifier {
  List<Doctor> doctors = [
    Doctor(name: 'Dr. Smith', specialization: 'Cardiologist'),
    Doctor(name: 'Dr. Johnson', specialization: 'Dermatologist'),
    Doctor(name: 'Dr. Williams', specialization: 'Gynecologist'),
  ];

  void addDoctor(Doctor doctor) {
    doctors.add(doctor);
    notifyListeners(); // Notify listeners that the data has changed
  }
}
