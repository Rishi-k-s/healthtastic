import 'package:flutter/material.dart';
import 'package:healthtastic/main_UI/Patient/PatientDashboard.dart';
import 'package:healthtastic/main_UI/Patient/createP2P.dart';
import 'package:healthtastic/services/authService.dart';
import 'package:healthtastic/services/database.dart';

class PatientDetalsScreen extends StatefulWidget {
  const PatientDetalsScreen({Key? key}) : super(key: key);

  @override
  _PatientDetalsScreenState createState() => _PatientDetalsScreenState();
}

class _PatientDetalsScreenState extends State<PatientDetalsScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                AuthService.signout();
                Navigator.pop(context);
              })
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
