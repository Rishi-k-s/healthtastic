import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class UserHelper {
  final String uid;
  UserHelper({required this.uid});

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<void> addUserRegisToFirebase(String name, String email, String aadar, String uid, String role) async {
    return await _database.collection('users').doc(uid).set({
      "name": name,
      "email": email,
      "uid": uid,
      "aadar": aadar,
      "Role": role,
    });
  }

  static Future<String> getuserRole() async {
    final User user = auth.currentUser!;
    final uid = user.uid;
    String role = '';
    await FirebaseFirestore.instance.doc('users/$uid').get().then((value) {
      role = value['Role'].toString();
    });
    return role;
  }

  // Get Doctor Uid
  static getDoctorUid() async {
    final User user = auth.currentUser!;
    final uid = user.uid;
    List<String> uidList = <String>[];
    try {
      await FirebaseFirestore.instance.collection("users").doc('$uid').get().then((value) {
        // first add the data to the Offset object
        List.from(value.data()!['Appoiments']).forEach((element) {
          String data = element;
          //then add the data to the List<Offset>, now we have a type Offset
          uidList.add(data);
        });
      });
      print('uvvvvvv +$uidList');
      return uidList;
    } catch (e) {
      print('uvvvvvv + null');
      return null;
    }
  }
}
