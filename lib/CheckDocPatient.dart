import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthtastic/auth/LoginPage.dart';
import 'package:healthtastic/main_UI/Patient/PatientDashboard.dart';
import 'package:healthtastic/main_UI/Doctor/doctorDashboard.dart';
import 'package:healthtastic/main_UI/Patient/PatientDetails.dart';
import 'package:healthtastic/services/authService.dart';
import 'package:healthtastic/services/database.dart';

class CheckRoleUser extends StatefulWidget {
  const CheckRoleUser({Key? key}) : super(key: key);

  @override
  _CheckRoleUserState createState() => _CheckRoleUserState();
}

class _CheckRoleUserState extends State<CheckRoleUser> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return RoleSelector();
          }
          return SignInLogInPage();
        });
  }
}

class RoleSelector extends StatefulWidget {
  const RoleSelector({Key? key}) : super(key: key);

  @override
  _RoleSelectorState createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  String role = "";

  Future<void> setRole() async {
    String roles = await UserHelper.getuserRole();
    setState(() {
      role = roles;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setRole();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(role + " is role from firebase");
    switch (role) {
      case 'Patient':
        return PatientDashboard();
        break;
      case 'Doctor':
        return DoctorDashboard();
        break;
      default:
        return Center(
          child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator()),
        );
    }
  }
}
