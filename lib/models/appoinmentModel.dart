import 'package:cloud_firestore/cloud_firestore.dart';

class AppoinmentModel {
  final String DoctorName;
  final String Speciality;
  final int dateTime;

  AppoinmentModel(this.DoctorName, this.Speciality, this.dateTime);
}
