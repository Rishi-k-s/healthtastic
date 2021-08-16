import 'package:flutter/material.dart';

class DashboardForPatient extends StatefulWidget {
  const DashboardForPatient({Key? key}) : super(key: key);

  @override
  _DashboardForPatientState createState() => _DashboardForPatientState();
}

class _DashboardForPatientState extends State<DashboardForPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Card(
              child: ListTile(),
            )
          ],
        ),
      ),
    );
  }
}
