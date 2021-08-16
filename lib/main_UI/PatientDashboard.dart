import 'package:flutter/material.dart';
import 'package:healthtastic/common/textstyles.dart';
import 'package:healthtastic/services/authService.dart';

class DashboardForPatient extends StatefulWidget {
  const DashboardForPatient({Key? key}) : super(key: key);

  @override
  _DashboardForPatientState createState() => _DashboardForPatientState();
}

class _DashboardForPatientState extends State<DashboardForPatient> {
  String? name;
  String? nosofappoin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome Back $name'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                AuthService.signout();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Upcoming Visits ($nosofappoin)',
              style: bigtextstyle,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 120,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.teal),
                  // height: 30,
                  width: 150,
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Card $index',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // color: Colors.lightBlue[300],
                ),
              ),
            ),
            Text(
              'Upcoming Visits',
              style: bigtextstyle,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
