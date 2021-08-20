import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthtastic/goglcal/calhelper.dart';
import 'package:flutter/material.dart';
import 'package:healthtastic/models/calModel.dart';

final CollectionReference mainCollection = FirebaseFirestore.instance.collection('appoinments');
final DocumentReference documentReference = mainCollection.doc('data');

class Storage {
  Future<void> storeEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference.collection('liveAppoinments').doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.set(data).whenComplete(() {
      print("Event added to the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> updateEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference.collection('liveAppoinments').doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.update(data).whenComplete(() {
      print("Event updated in the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> deleteEvent({required String id}) async {
    DocumentReference documentReferencer = documentReference.collection('liveAppoinments').doc(id);

    await documentReferencer.delete().catchError((e) => print(e));

    print('Event deleted, id: $id');
  }

  Stream<QuerySnapshot> retrieveEvents() {
    Stream<QuerySnapshot> myClasses = documentReference.collection('liveAppoinments').orderBy('start').snapshots();

    return myClasses;
  }
}
