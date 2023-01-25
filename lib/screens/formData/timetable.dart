import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time2study/screens/formData/activity_time.dart';
import 'package:time2study/screens/signup/home_page.dart';
import 'package:time2study/screens/view%20list/listTimetable.dart';
import '../../theme/colors/light_colors.dart';
import '../../widgets/stepper.dart';

class TimetableStudent extends StatefulWidget {
  const TimetableStudent({super.key});

  @override
  State<TimetableStudent> createState() => _TimetableStudentState();
}

class _TimetableStudentState extends State<TimetableStudent> {
  TextEditingController group = TextEditingController();
  TextEditingController start_time = TextEditingController();
  TextEditingController end_time = TextEditingController();
  TextEditingController location = TextEditingController();

  int? user_id;

  Future getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    user_id = prefs.getInt("user_id");
  }

  Future getSubjectDatas() async {
    //list <> tu adalah model
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/readSubject'));
    if (response.statusCode == 200) {
      var responseString = json.decode(response.body);
      return responseString;
    }
    //nama model jgk
  }

  Future addTimeTable(context) async {
    var data = {
      'subject_code': selectedSubject,
      'day': selectedDay,
      'group': group.text,
      'start_time': start_time.text,
      'end_time': end_time.text,
      'location': location.text,
      'user_id': user_id,
    };
    print(data);

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/storeTimeTable'),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
      },
    );
  }

  int _count = 1;
  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    //_formKey.currentState?.reset(); //set the initial value of text field
  }

  List<String> items = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Sunday'
  ];
  //int _count = 0;

  String? selectedDay = 'Monday';
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.kLightYellow,
          elevation: 0.5,
          //centerTitle: true,
          title: Text(
            'Timetable Form',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
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
          actions: [
            IconButton(
              onPressed: () {
                _showMoreVert(context);
              },
              icon: Icon(Icons.more_vert_rounded),
              color: Colors.black,
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TopStepper(step: 1),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _count,
                  itemBuilder: (context, index) {
                    return _form(index);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.arrow_circle_right_rounded),
          label: Text('Next'),
          backgroundColor: LightColors.kGreen,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          onPressed: () {
            // addTimeTable(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityTime()), //next page study time
            );
            //addTimeTable(context);
            // _showSuccess(context);
          },
        ));
  }

  _form(int index) {
    return FutureBuilder(
      future: getSubjectDatas(),
      builder: (context, snapshot) {
        // print(snapshot.data);
        if (snapshot.hasData) {
          List listSubjectData = snapshot.data;
          return Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(187, 255, 255, 255)),
              // color: Color.fromARGB(187, 255, 255, 255),
              width: double.infinity,
              child: Column(
                children: [
                  SingleChildScrollView(
                    //key: formKey,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 0, left: 20, right: 20, bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Subject',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    addTimeTable(context);
                                    group.clear();
                                    start_time.clear();
                                    end_time.clear();
                                    location.clear();
                                    _showSuccess(context);
                                  },
                                  child: Text('Add')),
                            ],
                          ),
                          DropdownButtonFormField(
                            hint: Text('Subject Code'),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book_rounded),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                            ),

                            // Initial Value
                            value: selectedSubject,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: listSubjectData.map((items) {
                              return DropdownMenuItem(
                                value: items['subject_code'].toString(),
                                child: Text(items['subject_code'].toString()),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (newValue) {
                              setState(() {
                                selectedSubject = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField(
                            hint: Text('Day'),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range_rounded),
                              //fillColor: Colors.red,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                            ),

                            // Initial Value
                            value: selectedDay,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDay = newValue!;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: group,
                            //controller: course_code,
                            //initialValue: 'Input text',
                            decoration: InputDecoration(
                              labelText: 'Group',
                              //errorText: 'Error message',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.school_rounded),
                              /*suffixIcon: Icon(
                                    Icons.error,
                                  ),*/
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                        controller: start_time,
                                        decoration: const InputDecoration(
                                          labelText: 'Start time',
                                          border: OutlineInputBorder(),
                                          prefixIcon:
                                              Icon(Icons.timelapse_rounded),
                                        ),
                                        readOnly:
                                            true, //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if (pickedTime != null) {
                                            print(pickedTime.format(
                                                context)); //output 10:51 PM
                                            DateTime parsedTime =
                                                DateFormat.jm().parse(pickedTime
                                                    .format(context)
                                                    .toString());
                                            //converting to DateTime so that we can further format on different pattern.
                                            print(
                                                parsedTime); //output 1970-01-01 22:53:00.000
                                            String formattedTime =
                                                DateFormat('HH:mm:ss')
                                                    .format(parsedTime);
                                            print(
                                                formattedTime); //output 14:59:00
                                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                                            setState(() {
                                              start_time.text =
                                                  formattedTime; //set the value of text field.
                                            });
                                          } else {
                                            print("Time is not selected");
                                          }
                                        }),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: TextFormField(
                                        controller: end_time,
                                        decoration: const InputDecoration(
                                          labelText: 'End time',
                                          border: OutlineInputBorder(),
                                          prefixIcon:
                                              Icon(Icons.timelapse_rounded),
                                        ),
                                        readOnly:
                                            true, //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if (pickedTime != null) {
                                            print(pickedTime.format(
                                                context)); //output 10:51 PM
                                            DateTime parsedTime =
                                                DateFormat.jm().parse(pickedTime
                                                    .format(context)
                                                    .toString());
                                            //converting to DateTime so that we can further format on different pattern.
                                            print(
                                                parsedTime); //output 1970-01-01 22:53:00.000
                                            String formattedTime =
                                                DateFormat('HH:mm:ss')
                                                    .format(parsedTime);
                                            print(
                                                formattedTime); //output 14:59:00
                                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                                            setState(() {
                                              end_time.text =
                                                  formattedTime; //set the value of text field.
                                            });
                                          } else {
                                            print("Time is not selected");
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: location,
                            //initialValue: 'Input text',
                            decoration: InputDecoration(
                              labelText: "Class's Location",
                              //errorText: 'Error message',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.map_rounded),
                              /*suffixIcon: Icon(
                                    Icons.error,
                                  ),*/
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        backgroundColor: Color.fromARGB(156, 255, 255, 255),
        title: new Text("Guide"),
        content: new Text(
            "In timetable form you need to insert all your timetable schedule for current semester."),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close')),
        ],
      );
    },
  );
}

void _showSuccess(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
        return const AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          icon: Icon(
            Icons.check_circle_outline_rounded,
            size: 40,
            color: Colors.green,
          ),
          content: Text(
            "Success added",
            textAlign: TextAlign.center,
          ),
        );
      });
}

void _showMoreVert(BuildContext context) {
  showModalBottomSheet(
      context: context,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     // <-- SEE HERE
      //     topLeft: Radius.circular(25.0),
      //     topRight: Radius.circular(25.0),
      //   ),
      // ),
      builder: (context) {
        return SizedBox(
          height: 160,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.question_mark_rounded),
                  title: Text('Guide'),
                  onTap: () {
                    _showDialog(context);
                  },
                ),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.list_alt_outlined),
                  title: Text('Timetable list'),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (),
                      ),
                    );*/
                  },
                ),
              ],
            ),
          ),
        );
      });
}
