import 'package:flutter/material.dart';

class EventInfo {
  final String id;
  final String name;
  final String description;
  final String location;
  final String link;
  final String docUid;
  final String docName;
  final String allergies;
  final List<dynamic> attendeeEmails;
  final bool shouldNotifyAttendees;
  final bool hasConfereningSupport;
  final int startTimeInEpoch;
  final int endTimeInEpoch;

  EventInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.link,
    required this.docName,
    required this.allergies,
    required this.attendeeEmails,
    required this.shouldNotifyAttendees,
    required this.hasConfereningSupport,
    required this.startTimeInEpoch,
    required this.endTimeInEpoch,
    required this.docUid,
  });

  EventInfo.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['desc'],
        location = snapshot['loc'],
        link = snapshot['link'],
        docName = snapshot['docName'],
        allergies = snapshot['allergies'],
        attendeeEmails = snapshot['emails'] ?? '',
        shouldNotifyAttendees = snapshot['should_notify'],
        hasConfereningSupport = snapshot['has_conferencing'],
        startTimeInEpoch = snapshot['start'],
        docUid = snapshot['docUid'],
        endTimeInEpoch = snapshot['end'];

  toJson() {
    return {
      'id': id,
      'name': name,
      'desc': description,
      'loc': location,
      'docName': docName,
      'allergies': allergies,
      'link': link,
      'emails': attendeeEmails,
      'should_notify': shouldNotifyAttendees,
      'has_conferencing': hasConfereningSupport,
      'start': startTimeInEpoch,
      'end': endTimeInEpoch,
      'docUid': docUid,
    };
  }
}
