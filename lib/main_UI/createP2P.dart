import 'package:flutter/material.dart';
import 'package:googleapis/analyticsreporting/v4.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:healthtastic/common/textstyles.dart';
import 'package:healthtastic/models/calModel.dart';
import 'package:healthtastic/gogl%20cal/calDatabase.dart';
import 'package:healthtastic/gogl%20cal/calhelper.dart';
import 'package:intl/intl.dart';

class CreateAppoin extends StatefulWidget {
  const CreateAppoin({Key? key}) : super(key: key);

  @override
  _CreateAppoinState createState() => _CreateAppoinState();
}

class _CreateAppoinState extends State<CreateAppoin> {
  Storage storage = Storage();
  CalendarClient calendarClient = CalendarClient();
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  late TextEditingController textControllerDate;
  late TextEditingController textControllerStartTime;
  late TextEditingController textControllerEndTime;

  String title = '';
  String docName = '';
  String desc = '';
  String location = '';
  String allergies = '';

  _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    ))!;
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textControllerDate.text = DateFormat.yMMMMd().format(selectedDate);
      });
    }
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    ))!;
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
        textControllerStartTime.text = selectedStartTime.format(context);
      });
    } else {
      setState(() {
        textControllerStartTime.text = selectedStartTime.format(context);
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    ))!;
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
        textControllerEndTime.text = selectedEndTime.format(context);
      });
    } else {
      setState(() {
        textControllerEndTime.text = selectedEndTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appoinment'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: commontextstyle,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                onChanged: (val) {
                  setState(() => title = val);
                },
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: commontextstyle,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                style: commontextstyle,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                onChanged: (val) {
                  setState(() => desc = val);
                },
                decoration: InputDecoration(
                  hintText: 'describtion',
                  hintStyle: commontextstyle,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                style: commontextstyle,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                onChanged: (val) {
                  setState(() => location = val);
                },
                decoration: InputDecoration(
                  hintText: 'Location',
                  hintStyle: commontextstyle,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 40.9,
                  width: 100.0,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xffEC5F5F)),
                      foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        int startTimeInEpoch = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedStartTime.hour,
                          selectedStartTime.minute,
                        ).millisecondsSinceEpoch;

                        int endTimeInEpoch = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedEndTime.hour,
                          selectedEndTime.minute,
                        ).millisecondsSinceEpoch;

                        await calendarClient
                            .insert(
                          title: title,
                          description: desc,
                          location: location,
                          docName: docName,
                          allergies: allergies,
                          hasConferenceSupport: true,
                          shouldNotifyAttendees: false,
                          startTime: DateTime.fromMillisecondsSinceEpoch(startTimeInEpoch),
                          endTime: DateTime.fromMillisecondsSinceEpoch(endTimeInEpoch),
                        )
                            .then(((eventData) async {
                          String eventId = eventData['id']!;
                          String eventLink = eventData['link']!;
                        }));
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ],
          )),
    );
  }
}
