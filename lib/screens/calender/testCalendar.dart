import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../model/timetableModel.dart';
class TestCalendar extends StatefulWidget {
  const TestCalendar({super.key});

  @override
  State<TestCalendar> createState() => _TestCalendarState();
}

class _TestCalendarState extends State<TestCalendar> {
  Future<List<TimetableModel>> getDataFromWeb() async {
  var data = await http.get(Uri.parse("http://10.0.2.2:8000/api/readTimeTable"));
  var jsonData = json.decode(data.body);
 
  final List<TimetableModel> appointmentData = [];
  //final Random random = new Random();
  for (var data in jsonData) {
    TimetableModel meetingData = TimetableModel(
        timetableId: data['Subject'],
        subjectCode: data['Subject'],
        startTime: data['StartTime'],
        day: data['day'],
        group: data['StartTime'],
        endTime: data['StartTime'],
        location: data['StartTime'],
        userId: data['EndTime'], 
        // background: _colorCollection[random.nextInt(9)],
        // allDay: data['AllDay']
        );
    appointmentData.add(meetingData);
  }
  return appointmentData;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
          future: getDataFromWeb(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                child: Container(
                    child: SfCalendar(
                      view: CalendarView.week,
                      initialDisplayDate: DateTime(2017, 6, 01, 9, 0, 0),
                      dataSource: MeetingDataSource(snapshot.data),
                    )),
              );
            }  else {
                  return CircularProgressIndicator();
                
            }
          },
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<TimetableModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subjectCode;
  }

  // @override
  // Color getColor(int index) {
  //   return appointments![index].background;
  // }

  // @override
  // bool isAllDay(int index) {
  //   return appointments![index].allDay;
  // }
}

