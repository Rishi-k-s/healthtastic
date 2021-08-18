import 'package:flutter/material.dart';
import 'package:healthtastic/common/textstyles.dart';
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
  String? name;
  String? aadaar;
  String? allergies;
  String? history;

  int _currentIndex = 2;
  final _formKey = GlobalKey<FormState>();
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
          Form(
              key: _formKey,
              child: (Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: commontextstyle,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Name',
                      hintStyle: commontextstyle,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('$aadaar')
                ],
              )))
        ],
      ),
    );
  }
}
