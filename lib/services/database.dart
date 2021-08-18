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
  final CollectionReference userCollection = _database.collection('users');

  Future<void> addUserRegisToFirebase(String name, String email, String aadar, String uid, String role, String docType, String minCost) async {
    final User user = auth.currentUser!;
    final uid = user.uid;
    return await _database.collection('users').doc(uid).set({
      "name": name,
      "email": email,
      "uid": uid,
      "aadar": aadar,
      "Role": role,
      "type": docType,
      "minCost": minCost,
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
      print(e);
      print('uvvvvvv + null');
      return null;
    }
  }

  // Stream<QuerySnapshot> get doctors {
  //   return userCollection.snapshots();
  // }

  // Future getUserDetals() async {
  //   List itemsList = [];
  //   try {
  //     await userCollection.get().then((querySnapshot) {
  //       querySnapshot.docs.forEach((element) {
  //         if(element.data()!['']){}
  //         itemsList.add(element.data());
  //       });
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

}

class DocDetals {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore _database = FirebaseFirestore.instance;
  final CollectionReference userCollection = _database.collection('users');

  Future getUserDetals() async {
    List itemsList = [];
    try {
      await userCollection.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['Role'] == 'Doctor') {
            itemsList.add(doc.data());
          } else {
            itemsList.add('NoDoc');
          }
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
