// // import 'dart:html';

// // import 'package:calendar_timeline/calendar_timeline.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class MyApp extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   List<Event> events = [];
// //   late DateTime _selectedDate;

// //   // Map<DateTime, List> _markedDateMap = {};
// //   // DateTime _currentDate = DateTime.now();

// //   @override
// //   void initState() {
// //     super.initState();
// //     getDataFromServer();
// //   }

// //   Future<void> getDataFromServer() async {
// //     var response = await http.get(Uri.parse("http://10.0.2.2:8000/api/rule"));
// //     if (response.statusCode == 200) {
// //       var data = jsonDecode(response.body);
// //       data.forEach((event) {
// //         var startTime = DateTime.parse(event['start_time']);
// //         var endTime = DateTime.parse(event['end_time']);
// //         // events.add(Event(
// //         //   start: startTime,
// //         //   end: endTime,
// //         //   title: event['subject_code'],
// //         // ));
// //         // if (_markedDateMap[startTime.toUtc()] == null) {
// //         //   _markedDateMap[startTime.toUtc()] = [
// //         //     {
// //         //       "start_time": startTime,
// //         //       "end_time": endTime,
// //         //       "subject_code": subject['subject_code'],
// //         //     }
// //         //   ];
// //         // } else {
// //         //   _markedDateMap[startTime.toUtc()]?.add({
// //         //     "start_time": startTime,
// //         //     "end_time": endTime,
// //         //     "subject_code": subject['subject_code'],
// //         //   });
// //         // }
// //       });
// //       setState(() {
// //         // this._markedDateMap = _markedDateMap;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: CalendarTimeline(
// //         showYears: true,
// //         initialDate: _selectedDate,
// //         firstDate: DateTime.now(),
// //         lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
// //         onDateSelected: (date) => setState(() => _selectedDate = date),
// //         leftMargin: 20,
// //         monthColor: Colors.white70,
// //         dayColor: Colors.teal[200],
// //         dayNameColor: const Color(0xFF333A47),
// //         activeDayColor: Colors.white,
// //         activeBackgroundDayColor: Colors.redAccent[100],
// //         dotsColor: const Color(0xFF333A47),
// //         selectableDayPredicate: (date) => date.day != 23,
// //         locale: 'en',
// //         // events: events,
// //       ),
// //       // body: Column(
// //       //   children: <Widget>[
// //       //     CalendarCarousel(
// //       //       onDayPressed: (DateTime date, List subjects) {
// //       //         this.setState(() => _currentDate = date);
// //       //         subjects.forEach((subject) => print(subject));
// //       //       },
// //       //       daysHaveCircularBorder: true,
// //       //       markedDatesMap: this._markedDateMap,
// //       //     ),
// //       //     Text("Events on $_currentDate"),
// //       //   ],
// //       // ),
// //     );
// //   }
// // }
// import 'package:calendar_timeline/calendar_timeline.dart';
// import 'package:flutter/material.dart';

// class TestCalendar1 extends StatefulWidget {
//   const TestCalendar1({super.key});

//   @override
//   State<TestCalendar1> createState() => _TestCalendar1State();
// }

// class _TestCalendar1State extends State<TestCalendar1> {
//   late DateTime _selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     _resetSelectedDate();
//   }

//   void _resetSelectedDate() {
//     _selectedDate = DateTime.now().add(const Duration(days: 2));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF333A47),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'Calendar Timeline',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline6!
//                     .copyWith(color: Colors.tealAccent[100]),
//               ),
//             ),
//             CalendarTimeline(
//               showYears: true,
//               initialDate: _selectedDate,
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
//               onDateSelected: (date) => setState(() => _selectedDate = date),
//               leftMargin: 20,
//               monthColor: Colors.white70,
//               dayColor: Colors.teal[200],
//               dayNameColor: const Color(0xFF333A47),
//               activeDayColor: Colors.white,
//               activeBackgroundDayColor: Colors.redAccent[100],
//               dotsColor: const Color(0xFF333A47),
//               selectableDayPredicate: (date) => date.day != 23,
//               locale: 'en',
//             ),
//             const SizedBox(height: 20),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 16),
//             //   child: TextButton(
//             //     style: ButtonStyle(
//             //       backgroundColor: MaterialStateProperty.all(Colors.teal[200]),
//             //     ),
//             //     child: const Text(
//             //       'RESET',
//             //       style: TextStyle(color: Color(0xFF333A47)),
//             //     ),
//             //     onPressed: () => setState(() => _resetSelectedDate()),
//             //   ),
//             // ),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 'Selected date is $_selectedDate',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:calendar_appbar/calendar_appbar.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';

// class DatePickerCustom extends StatefulWidget {
//   const DatePickerCustom({Key? key}) : super(key: key);

//   @override
//   State<DatePickerCustom> createState() => _DatePickerCustomState();
// }

// class _DatePickerCustomState extends State<DatePickerCustom> {
//   DateTime? selectedDate;
//   int selectedIndex = 0;
//   DateTime now = DateTime.now();
//   late DateTime lastDayOfMonth;
//   // Random random = new Random();

//   // @override
//   // void initState() {
//   //   setState(() {
//   //     selectedDate = DateTime.now();
//   //   });
//   //   super.initState();
//   // }

//   // int selectedIndex = 0;
//   // DateTime now = DateTime.now();
//   // late DateTime lastDayOfMonth;
//   @override
//   void initState() {
//     super.initState();
//     lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
//   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: CalendarAppBar(
// //         onDateChanged: (value) => setState(() => selectedDate = value),
// //         lastDate: DateTime.now(),
// //         //   events: List.generate(
// //         //       100,
// //         //       (index) => DateTime.now()
// //         //           .subtract(Duration(days: index* random.nextInt(5)))),
// //         // ),
// //       ),
// //       body: Center(child: Text(selectedDate.toString())),
// //     );
// //   }
// // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         toolbarHeight: 148.0,
//         title: Column(
//           children: [
//             Row(
//               children: const [
//                 Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.orange,
//                 ),
//                 Expanded(
//                     child: Text("Workout",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.black,
//                         )))
//               ],
//             ),
//             const SizedBox(height: 16.0),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               physics: const ClampingScrollPhysics(),
//               child: Row(
//                 children: List.generate(
//                   lastDayOfMonth.day,
//                   (index) {
//                     final currentDate =
//                         lastDayOfMonth.add(Duration(days: index + 1));
//                     final dayName = DateFormat('E').format(currentDate);
//                     return Padding(
//                       padding: EdgeInsets.only(
//                           left: index == 0 ? 16.0 : 0.0, right: 16.0),
//                       child: GestureDetector(
//                         onTap: () => setState(() {
//                           selectedIndex = index;
//                         }),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: 42.0,
//                               width: 42.0,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: selectedIndex == index
//                                     ? Colors.orange
//                                     : Colors.transparent,
//                                 borderRadius: BorderRadius.circular(44.0),
//                               ),
//                               child: Text(
//                                 dayName.substring(0, 1),
//                                 style: TextStyle(
//                                   fontSize: 24.0,
//                                   color: selectedIndex == index
//                                       ? Colors.white
//                                       : Colors.black54,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Text(
//                               "${index + 1}",
//                               style: const TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.black54,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Container(
//                               height: 2.0,
//                               width: 28.0,
//                               color: selectedIndex == index
// ? Colors.orange
//                                   : Colors.transparent,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/studyPlanMonModel.dart';

class DatePickerCustom extends StatefulWidget {
  const DatePickerCustom({Key? key}) : super(key: key);

  @override
  State<DatePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom> {
  Future<List<StudyPlanMonModelElement>?> getStudyPlan() async {
    //list <> tu adalah model

    final response = await http.get(Uri.parse("http://10.0.2.2:8000/api/rule"));
    //.get(Uri.parse("http://10.0.2.2:8000/api/${widget.userId}/readActivityTime"));
    if (response.statusCode == 200) {
      var responseString = response.body;
      //return studyPlanMonModelFromJson(responseString);
    }
    //nama model jgk
  }

  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 148.0,
        title: Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.orange,
                ),
                Expanded(
                    child: Text("Study Plan",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        )))
              ],
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                children: List.generate(
                  lastDayOfMonth.day,
                  (index) {
                    final currentDate =
                        lastDayOfMonth.add(Duration(days: index + 1));
                    final dayName = DateFormat('E').format(currentDate);
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 16.0 : 0.0, right: 16.0),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          selectedIndex = index;
                        }),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 42.0,
                              width: 42.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Colors.orange
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(44.0),
                              ),
                              child: Text(
                                dayName.substring(0, 1),
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "${index + 1}",
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              height: 2.0,
                              width: 28.0,
                              color: selectedIndex == index
                                  ? Colors.orange
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          10,
          20,
          10,
          0,
        ),
        child: FutureBuilder(
          future: getStudyPlan(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              final listStudyPlan = snapshot.data;
              return Container(
                child: ListView.builder(
                    itemCount: listStudyPlan!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecondPage(
                                              id: listStudent[index].id.toString(),
                                            )),
                                  );*/
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadowColor: Color.fromARGB(117, 255, 255, 255),
                            //color: LightColors.kLightYellow,
                            color: Color.fromARGB(253, 255, 255, 255),
                            child: ListTile(
                              //leading: Icon(Icons.icecream),
                              /*leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                          "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
                                    ),*/
                              title: Row(
                                children: [
                                  // Text(listStudyPlan[index].subjectCode),
                                  // SizedBox(width: 5),
                                  // Text("(" + listStudyPlan[index].group + ")"),
                                  Row()
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Text(listStudyPlan[index].day),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(listStudyPlan[index].startTime),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(listStudyPlan[index].endTime),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      color: Colors.green,
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {},
                                      color: Colors.redAccent,
                                      icon: Icon(Icons.delete_rounded))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
