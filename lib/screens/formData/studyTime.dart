import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time2study/screens/formData/subject_form.dart';
import 'package:time2study/screens/signup/home_page.dart';
import 'package:time2study/widgets/stepper.dart';
import 'package:http/http.dart' as http;

import '../../theme/colors/light_colors.dart';
class StudyTime extends StatefulWidget {
  const StudyTime({super.key});

  @override
  State<StudyTime> createState() => _StudyTimeState();
}

class _StudyTimeState extends State<StudyTime> {
  TextEditingController day = TextEditingController();
  TextEditingController time_from = TextEditingController();
  TextEditingController time_to = TextEditingController();

  Future addStudyTime(context) async {
    var data = {
      'day': day.text,
      'time_from': time_from.text,
      'time_to': time_to.text,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/storeStudyTime'),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
      },
    );

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Success Created'),
        content: const Text('Your Student Successfully Created'),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }

  //List<_SubjectForm> subjects = [];
  int _count = 0;

  @override
  void initState() {
    time_from.text = "";
    time_to.text = "";
    super.initState();
    _count = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      appBar: AppBar(
         //backgroundColor: LightColors.kDarkYellow,
        //title: Text('Study Time'),
      ),
      body: SingleChildScrollView(
        //physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20),
          //margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TopStepper(step: 3),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                  'Study Time',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 50),
                //ElevatedButton(onPressed: () {}, child: Text('+  Study Time')),
              ]),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Productive Day',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
              SizedBox(height: 20.0),
            
          
          TextFormField(
            controller: day,
            //initialValue: 'Input text',
            decoration: InputDecoration(
              labelText: 'Day',
              //errorText: 'Error message',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_month_rounded),
              suffixIcon: Icon(
                Icons.arrow_downward_rounded,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                      controller: time_from,
                      //initialValue: 'Input text',
                      decoration: InputDecoration(
                        labelText: 'From',
                        //errorText: 'Error message',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month_rounded),
                        /*suffixIcon: Icon(
                          Icons.error,
                        ),*/
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
      
                        if (pickedTime != null) {
                          print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime =
                              DateFormat('HH:mm:ss').format(parsedTime);
                          print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.
      
                          setState(() {
                            time_from.text =
                                formattedTime; //set the value of text field.
                          });
                        } else {
                          print("Time is not selected");
                        }
                      })),
              SizedBox(width: 10),
              Expanded(
                  child: TextFormField(
                      controller: time_to,
                      //initialValue: 'Input text',
                      decoration: InputDecoration(
                        labelText: 'To',
                        //errorText: 'Error message',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month_rounded),
                        /*suffixIcon: Icon(
                          Icons.error,
                        ),*/
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
      
                        if (pickedTime != null) {
                          print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime =
                              DateFormat('HH:mm:ss').format(parsedTime);
                          print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.
      
                          setState(() {
                            time_to.text =
                                formattedTime; //set the value of text field.
                          });
                        } else {
                          print("Time is not selected");
                        }
                      })),
              SizedBox(width: 10),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(100)
                    //more than 50% of width makes circle
                    ),
                child: IconButton(
                    onPressed: () async {
                      setState(() {
                        _count++;
                      });
                      //addStudyTime(context);
                    },
                    icon: Icon(Icons.add)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          //padding: EdgeInsets.only(right: 50)
                        ),
                        onPressed: () {
                          addStudyTime(context);
                          showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Success Created'),
                              content:
                                  const Text('Do you want to add another study time?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Add Study Time'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StudyTime()),
                                    );
                                  },
                                ),
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               HomePage()), //next page study time
                                    );
                                     //This makes sure the textfield is cleared after page is pushed.
                                      
                                  },
                                ),
                              ],
                            ));
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SubjectForm1()),
                          );*/
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
                            MaterialPageRoute(builder: (context) => const SubjectForm1()),
                          );
                        },
                        child: const Text(
                          'BACK',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
            ],
            ),
          ),
      ),
      );
  }
}