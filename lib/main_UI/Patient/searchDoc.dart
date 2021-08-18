import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/compute/v1.dart';
import 'package:googleapis/serviceconsumermanagement/v1.dart';
import 'package:healthtastic/main_UI/Patient/createP2P.dart';
import 'package:provider/provider.dart';
import 'package:healthtastic/services/database.dart';

class SearchDoctors extends StatefulWidget {
  const SearchDoctors({Key? key}) : super(key: key);

  @override
  _SearchDoctorsState createState() => _SearchDoctorsState();
}

class _SearchDoctorsState extends State<SearchDoctors> {
  List doctorProfileList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDoctorList();
  }

  fetchDoctorList() async {
    dynamic result = await DocDetals().getUserDetals();

    if (result == null) {
      print('No doctors in your area');
    } else {
      setState(() {
        doctorProfileList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
            itemCount: doctorProfileList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(doctorProfileList[index]['name']),
                  subtitle: Text(doctorProfileList[index]['type']),
                  trailing: Text(doctorProfileList[index]['minCost']),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateAppoin(),
          ),
        );
      }),
    );
  }
}
