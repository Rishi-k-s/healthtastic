import 'package:flutter/material.dart';
import 'package:healthtastic/auth/LoginPage.dart';
import '../services/authService.dart';
import 'package:provider/provider.dart';
import 'package:healthtastic/CheckDocPatient.dart';
import 'package:healthtastic/common/textstyles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  String email = '';
  String name = '';
  String? role;
  String aadhaar = '';
  String password = '';
  String dropdownValue = 'Patient';
  bool hiddenPassword = true;
  bool loading = false;

  void _togglePasswordView() {
    setState(() {
      hiddenPassword = !hiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 123.0,
            ),
            SizedBox(
              height: 12.0,
            ),
            Center(
              child: Container(
                width: 376.0,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        // height: 56.9,
                        child: TextFormField(
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
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        // height: 56.9,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: commontextstyle,
                          validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email',
                            hintStyle: commontextstyle,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        // height: 56.9,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          style: commontextstyle,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Password',
                              hintStyle: commontextstyle,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: InkWell(onTap: _togglePasswordView, child: Icon(hiddenPassword ? Icons.visibility : Icons.visibility_off))),
                          obscureText: hiddenPassword,
                          validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        // height: 56.9,
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          style: commontextstyle,
                          validator: (val) => val!.isEmpty ? 'Required' : null,
                          onChanged: (val) {
                            setState(() => aadhaar = val);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Enter your Aadhaar number',
                            hintStyle: commontextstyle,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['Patient', 'Doctor'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 17.0,
                      ),
                      Container(
                          height: 56.9,
                          width: 376.0,
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xffEC5F5F)),
                                foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff)),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = await _auth.registerWithEmailPasswordStudent(
                                      email: email, password: password, aadar: aadhaar, name: name, role: role);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = 'Could not Register with those credentials';
                                      // return the error screen
                                      final snackBar = SnackBar(
                                        content: Text('$error'),
                                      );
                                      Future.delayed(const Duration(seconds: 1), () {
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      });
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text(
                                'Register',
                                style: commontextstyle,
                              ))),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                          height: 30.9,
                          width: 100.0,
                          child: TextButton(
                            style: ButtonStyle(
                              // backgroundColor: MaterialStateProperty.all<Color>(Color(0xffEC5F5F)),
                              foregroundColor: MaterialStateProperty.all<Color>(Color(0xff1ecbe1)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'SignIn',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
