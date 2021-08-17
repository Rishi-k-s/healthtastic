import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthtastic/CheckDocPatient.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:url_launcher/url_launcher.dart';
import 'gogl cal/calhelper.dart';
import 'dataSecrets.dart';
// import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp;

  var _clientID = new ClientId(Secret.getId(), "");
  const _scopes = const [cal.CalendarApi.calendarScope];
  await clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) async {
    CalendarClient.calendar = cal.CalendarApi(client);
  });

  runApp(MyApp());
}

void prompt(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
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
