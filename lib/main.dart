import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthtastic/CheckDocPatient.dart';
import 'package:healthtastic/services/authService.dart';
import 'package:healthtastic/auth/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthtastic/main_UI/doctorDashboard.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthtastic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckRoleUser(),
    );
  }
}
