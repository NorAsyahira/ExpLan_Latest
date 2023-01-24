import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import '../../model/activityModel.dart';
import '../../theme/colors/light_colors.dart';

class DynamicEvents extends StatefulWidget {
  const DynamicEvents({super.key});

  @override
  State<DynamicEvents> createState() => _DynamicEventsState();
}

class _DynamicEventsState extends State<DynamicEvents> {
  late CalendarDataSource _dataSource;

  // Future<List<ActivityModel>?> getActivityTimes() async {
  //   //list <> tu adalah model
  //   final response =
  //       await http.get(Uri.parse("http://10.0.2.2:8000/api/readTimeTable"));
  //   //.get(Uri.parse("http://10.0.2.2:8000/api/${widget.userId}/readActivityTime"));
  //   if (response.statusCode == 200) {
  //     var responseString = response.body;
  //     return activityModelFromJson(responseString);
  //   }
  //   //nama model jgk
  // }

  Future getTimetable() async {
    //list <> tu adalah model
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/readTimeTable'));
    if (response.statusCode == 200) {
      var responseString = json.decode(response.body);
      return responseString;
    }
    //nama model jgk
  }

  @override
  void initState() {
    //_dataSource = _getDataSource();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kLightYellow,
        centerTitle: true,
        title: Text(
          'Study Plan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            //dataSource: _dataSource,
            view: CalendarView.week,
            firstDayOfWeek: 1,
            dataSource: MeetingDataSource(getAppointments()),

            onTap: calendarTapped,
            allowedViews: const [
              CalendarView.day,
              CalendarView.week,
              CalendarView.workWeek,
              CalendarView.month,
              CalendarView.timelineDay,
              CalendarView.timelineWeek,
              CalendarView.timelineWorkWeek,
              CalendarView.timelineMonth,
              CalendarView.schedule
            ],
            monthViewSettings: const MonthViewSettings(showAgenda: true),
          ),
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    Appointment app = Appointment(
        startTime: calendarTapDetails.date!,
        endTime: calendarTapDetails.date!.add(const Duration(hours: 1)),
        subject: 'Tapped appointment',
        color: Colors.greenAccent);
    _dataSource.appointments!.add(app);
    _dataSource
        .notifyListeners(CalendarDataSourceAction.add, <Appointment>[app]);
  }

//   _DataSource _getDataSource() {
//     List<Appointment> appointments = <Appointment>[];
//     appointments.add(Appointment(
//       startTime: DateTime.now(),
//       //startTime: getTimetable(),
//       endTime: DateTime.now().add(const Duration(hours: 1)),
//       subject: 'Meeting',
//       color: Colors.teal,
//     ));
//     return _DataSource(appointments);
//   }
// }

// class _DataSource extends CalendarDataSource {
//   _DataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 10, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue,
      //recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
