import 'package:flutter/material.dart';
import 'package:healthtastic/auth/RegisterPage.dart';
import '../services/authService.dart';
import 'package:provider/provider.dart';
import 'package:healthtastic/CheckDocPatient.dart';
import 'package:healthtastic/common/textstyles.dart';

class SignInLogInPage extends StatefulWidget {
  const SignInLogInPage({Key? key}) : super(key: key);

  @override
  _SignInLogInPageState createState() => _SignInLogInPageState();
}

class _SignInLogInPageState extends State<SignInLogInPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  String email = '';
  String password = '';
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
        title: Text('SignIn'),
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
                                  dynamic result = await _auth.signInWithEmailPassword(email: email, password: password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = 'Could not sign in with those credentials';
                                      // return the error screen
                                      final snackBar = SnackBar(
                                        content: Text('$error'),
                                      );
                                      Future.delayed(const Duration(seconds: 1), () {
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      });
                                    });
                                  }
                                }
                              },
                              child: Text(
                                'Log In',
                                style: commontextstyle,
                              ))),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'New user?',
                        style: TextStyle(color: Colors.grey[700]),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                              );
                            },
                            child: Text(
                              'Register',
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
