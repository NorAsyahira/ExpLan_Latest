import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time2study/screens/formData/personalData.dart';
import 'package:time2study/screens/formData/studyTime.dart';
import 'package:time2study/widgets/stepper.dart';
import 'package:http/http.dart' as http;

import '../../model/courseModel.dart';

class SubjectForm1 extends StatefulWidget {
  const SubjectForm1({super.key});

  @override
  State<SubjectForm1> createState() => _SubjectForm1State();
}

class _SubjectForm1State extends State<SubjectForm1> {
  //TextEditingController course_code = TextEditingController();
  //TextEditingController day = TextEditingController();
  TextEditingController start_time = TextEditingController();
  TextEditingController end_time = TextEditingController();

  Future getCourseDatas() async {
    //list <> tu adalah model
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/readCourse'));
    if (response.statusCode == 200) {
      var responseString = json.decode(response.body);
      return responseString;
    }
    //nama model jgk
  }

  Future addSubject(context) async {
    var data = {
      //'course_code': course_code.text,
      'course_code': selectedCourse,
      //'day': selectedDay,
      'start_time': start_time.text,
      'end_time': end_time.text,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/storeSubject'),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
      },
    );

    @override
    void initState() {
      start_time.text = "";
      end_time.text = "";
      selectedCourse = "";
      //set the initial value of text field
      super.initState();
    }
  }

 
  String? selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getCourseDatas(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List listCourseData = snapshot.data;

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TopStepper(step: 2),
                    SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Subject Data',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.w700),
                          ),
                          //SizedBox(width: 10),
                          /*ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _count++;
                          });
                        },
                        child: Text('Add Subject')),*/
                        ]),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Subject list based on timetable',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    /*Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _count,
                  itemBuilder: (context, index) {
                    return _form(index);
                  },
                ),
              ),*/
                    SizedBox(height: 20),
                    /*TextFormField(
                //controller: subject_name,
                controller: course_code,
                //initialValue: 'Input text',
                decoration: InputDecoration(
                  labelText: 'Course Code',
                  //errorText: 'Error message',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                  /*suffixIcon: Icon(
                          Icons.error,
                        ),*/
                ),
              ),*/
                    DropdownButtonFormField(
                      hint: Text('Course Code'),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),

                      // Initial Value
                      value: selectedCourse,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: listCourseData.map((items) {
                        return DropdownMenuItem(
                          value: items['course_code'].toString(),
                          child: Text(items['course_name'].toString()),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        setState(() {
                          selectedCourse = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                              controller: start_time,
                              decoration: const InputDecoration(
                                labelText: 'Start time',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.timelapse_rounded),
                              ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  print(pickedTime
                                      .format(context)); //output 10:51 PM
                                  DateTime parsedTime = DateFormat.jm().parse(
                                      pickedTime.format(context).toString());
                                  //converting to DateTime so that we can further format on different pattern.
                                  print(
                                      parsedTime); //output 1970-01-01 22:53:00.000
                                  String formattedTime =
                                      DateFormat('HH:mm:ss').format(parsedTime);
                                  print(formattedTime); //output 14:59:00
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
                                prefixIcon: Icon(Icons.timelapse_rounded),
                              ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  print(pickedTime
                                      .format(context)); //output 10:51 PM
                                  DateTime parsedTime = DateFormat.jm().parse(
                                      pickedTime.format(context).toString());
                                  //converting to DateTime so that we can further format on different pattern.
                                  print(
                                      parsedTime); //output 1970-01-01 22:53:00.000
                                  String formattedTime =
                                      DateFormat('HH:mm:ss').format(parsedTime);
                                  print(formattedTime); //output 14:59:00
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
                    SizedBox(height: 10),
                    /*TextFormField(
                controller: description,
                //initialValue: 'Input text',
                decoration: InputDecoration(
                  labelText: 'Description',
                  //errorText: 'Error message',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                  /*suffixIcon: Icon(
                          Icons.error,
                        ),*/
                ),
              ),*/
                    SizedBox(height: 20),
                    //DottedLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              //padding: EdgeInsets.only(right: 50)
                            ),
                            onPressed: () {
                              addSubject(context);
                              //addPersonalData(context);
                            },
                            child: const Text(
                              'DONE',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 80,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              //padding: EdgeInsets.only(right: 50)
                            ),
                            onPressed: () {
                              addSubject(context);
                              //addPersonalData(context);
                              /*showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Success Created'),
                                  content: const Text(
                                      'Do you want to add another subject?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Add Subject'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SubjectForm1()),
                                        );
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Next Page'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const StudyTime()), //next page study time
                                        );
                                        //This makes sure the textfield is cleared after page is pushed.
                                      },
                                    ),
                                  ],
                                ));*/
                            },
                            child: const Text(
                              'BACK',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    //padding: EdgeInsets.only(right: 50)
                  ),
                  onPressed: () {
                    addSubject(context);
                    //addPersonalData(context);
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Success Created'),
                              content:
                                  const Text('Do you want to add another subject?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Add Subject'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SubjectForm1()),
                                    );
                                  },
                                ),
                                TextButton(
                                  child: const Text('Next Page'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StudyTime()), //next page study time
                                    );
                                     //This makes sure the textfield is cleared after page is pushed.
                                      
                                  },
                                ),
                              ],
                            ));
                  },
                  child: const Text(
                    'DONE',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          //padding: EdgeInsets.only(right: 50)
                        ),
                        onPressed: () {
                          //addPersonalData(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PersonalData()),
                          );
                        },
                        child: const Text(
                          'BACK',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),*/
                    SizedBox(height: 40),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
