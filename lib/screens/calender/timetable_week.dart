import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'package:time2study/screens/signup/home_page.dart';

import '../../theme/colors/light_colors.dart';

class TimetableWeek extends StatefulWidget {
  const TimetableWeek({super.key});

  @override
  State<TimetableWeek> createState() => _TimetableWeekState();
}

class _TimetableWeekState extends State<TimetableWeek> {
  Future getSubjectDatas() async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kLightYellow,
        // centerTitle: true,
        elevation: 1,
        title: Text(
          'Study Plan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage()), //next page study time
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
          future: getSubjectDatas(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DateTime date = DateTime.now();
              return Container(
                child: SfCalendar(
                  view: CalendarView.week,
                  firstDayOfWeek: date.weekday,
                  dataSource: _getCalendarDataSource(snapshot.data),
                  appointmentTimeTextFormat: 'HH:mm',
                  timeSlotViewSettings: TimeSlotViewSettings(
                    timeIntervalHeight: 200,
                  ),
                  specialRegions: _getTimeRegions(),
                  appointmentBuilder: appointmentBuilder,
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  _AppointmentDataSource _getCalendarDataSource(data) {
    List<Appointment> appointments = <Appointment>[];
    DateTime date = DateTime.now();
    for (var i = 0; i < data.length; i++) {
      appointments.add(Appointment(
          startTime: DateTime(
            int.parse(
              data[i]['date_year'],
            ),
            int.parse(
              data[i]['date_month'],
            ),
            int.parse(
              data[i]['date_day'],
            ),
            int.parse(
              data[i]['start_time_hour'],
            ),
            // int.parse(
            //   data[i]['start_time_minute'],
            // ),
            0,
          ),
          endTime: DateTime(
            int.parse(
              data[i]['start_time_minute'],
            ),
            int.parse(
              data[i]['date_year'],
            ),
            int.parse(
              data[i]['date_month'],
            ),
            int.parse(
              data[i]['date_day'],
            ),
            int.parse(
              data[i]['end_time_hour'],
            ),
            // int.parse(
            //   data[i]['end_time_minute'],
            // ),
            0,
          ),
          subject: data[i]['subject_code'],
          color: LightColors.kGreen,
          recurrenceRule: 'FREQ=DAILY;INTERVAL=4;COUNT=12'));
    }

    return _AppointmentDataSource(appointments);
  }

  //  _AppointmentDataSource _getActivityData(data) {
  //   List<Appointment> appointments = <Appointment>[];
  //   DateTime date = DateTime.now();
  //   for (var i = 0; i < data.length; i++) {
  //     appointments.add(Appointment(
  //       startTime: DateTime(
  //         int.parse(
  //           data[i]['date_year'],
  //         ),
  //         int.parse(
  //           data[i]['date_month'],
  //         ),
  //         int.parse(
  //           data[i]['date_day'],
  //         ),
  //         int.parse(
  //           data[i]['start_time_hour'],
  //         ),
  //         int.parse(
  //           data[i]['start_time_minute'],
  //         ),
  //         0,
  //       ),
  //       endTime: DateTime(
  //         int.parse(
  //           data[i]['start_time_minute'],
  //         ),
  //         int.parse(
  //           data[i]['date_year'],
  //         ),
  //         int.parse(
  //           data[i]['date_month'],
  //         ),
  //         int.parse(
  //           data[i]['date_day'],
  //         ),
  //         int.parse(
  //           data[i]['end_time_hour'],
  //         ),
  //         int.parse(
  //           data[i]['end_time_minute'],
  //         ),
  //         0,
  //       ),
  //       subject: data[i]['subject_code'],
  //       color: Colors.green,
  //     ));
  //   }

  //   return _AppointmentDataSource(appointments);
  // }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Appointment appointment =
        calendarAppointmentDetails.appointments.first;
    return Container(
      // width: calendarAppointmentDetails.bounds.width / 1,
      // height: calendarAppointmentDetails.bounds.height / 1,
      color: appointment.color,
      child: Text(
        '${appointment.subject}${DateFormat(' (hh:mm a').format(appointment.startTime)}-${DateFormat('hh:mm a)').format(appointment.endTime)}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    regions.add(TimeRegion(
        startTime: DateTime(2023, 01, 14, 09, 0, 0),
        endTime: DateTime(2023, 01, 14, 10, 0, 0),
        color: Colors.grey.withOpacity(0.2),
        recurrenceRule: 'FREQ=WEEKLY; BYDAY=TUSEDAY, THURSDAY',
        //recurrenceRule: 'FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR;INTERVAL=1',
        textStyle: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        text: 'Rest'));
    return regions;
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
