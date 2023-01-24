import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time2study/screens/calender/timetable_week.dart';
import 'package:time2study/screens/formData/timetable.dart';
import 'package:time2study/screens/signup/home_page.dart';
import 'package:time2study/screens/view%20list/listActivityTime.dart';
import '../../model/activityModel.dart';
import '../../model/userModel.dart';
import '../../theme/colors/light_colors.dart';
import '../../widgets/back_button.dart';
import '../../widgets/stepper.dart';

class ActivityTime extends StatefulWidget {
  const ActivityTime({super.key});

  @override
  State<ActivityTime> createState() => _ActivityTimeState();
}

class _ActivityTimeState extends State<ActivityTime> {
  //final formKey = GlobalKey<FormState>();
  TextEditingController activity_name = TextEditingController();
  int? user_id;

  Future getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getInt("user_id");
    });
  }

  Future addActivityTime(context) async {
    var data = {
      'activity_name': activity_name.text,
      'hour': hour,
      'activity_type': selectedActivityType,
      'frequency_rate': selectedRate,
      'user_id': user_id,
    };

    print(data);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/storeActivityTime'),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
      },
    );
  }

  @override
  void initState() {
    //selectedHour = "";
    hour = "";
    selectedActivityType = "";
    selectedRate = "";
    getSharedPrefs();
    super.initState();
  }

  //List<String> items3 = ['1 Hour', '2 Hour', '3 Hour', '4 Hour', '5 Hour'];
  List<String> items1 = ['Rest', 'Hobby', 'Habbit'];
  List<String> items2 = [
    'Every Day',
    'One times a day',
    'One times a week',
    'Others'
  ];

  //String? selectedHour = '1 Hour';
  String? selectedActivityType = 'Rest';
  String? selectedRate = 'Every Day';

  String? hour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kLightYellow,
        elevation: 0.5,
        //centerTitle: true,
        title: Text(
          'Activity Time Form',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        /*title: Text("List Activity Time", style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,

          ),),*/
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TimetableStudent()), //next page study time
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
              addActivityTime(context);
              setState(() {
                activity_name.clear();
                //emailFieldController.clear();
                //addressFieldController.clear();
              });
              _showSuccess(context);
            },
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           ListTimetable()), //next page study time
            // );

            icon: Icon(Icons.add),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              _showMoreVert(context);
            },
            icon: Icon(Icons.more_vert_rounded),
            color: Colors.black,
          ),
        ],
      ),
      /*appBar: AppBar(
        backgroundColor: LightColors.kLightYellow,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),
        title: Text('Activity Time', 
        style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.question_mark_rounded, color: Colors.black,))
        ],
        
      ),*/
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            //key: formKey,
            children: [
              /*Row(
                children: [
                  MyBackButton(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Activity Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        _showMoreVert(context);
                      },
                      icon: Icon(Icons.more_vert_rounded)),
                  /*IconButton(
                      onPressed: () {
                        _showDialog(context);
                      },
                      icon: Icon(Icons.question_mark_outlined, size: 20))*/
                ],
              ),
              SizedBox(height: 40),*/
              TopStepper(step: 2),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        //TopStepper(step: 2),
                        SizedBox(height: 20),

                        SizedBox(height: 20),
                        TextFormField(
                          controller: activity_name,
                          decoration: InputDecoration(
                            labelText: 'Activity Name',
                            //errorText: 'Error message',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.edit),
                            /*suffixIcon: Icon(
                                      Icons.error,
                                    ),*/
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Hour to spend',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: LightColors.kPalePink,
                                    borderRadius: BorderRadius.circular(9)),
                                child: RadioListTile(
                                  title: Text("1 Hour"),
                                  value: "1 Hour",
                                  groupValue: hour,
                                  onChanged: (value) {
                                    setState(() {
                                      hour = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: LightColors.kPalePink,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: RadioListTile(
                                  title: Text("2 Hour"),
                                  value: "2 Hour",
                                  groupValue: hour,
                                  onChanged: (value) {
                                    setState(() {
                                      hour = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: LightColors.kPalePink,
                                    borderRadius: BorderRadius.circular(9)),
                                child: RadioListTile(
                                  title: Text("3 Hour"),
                                  value: "3 Hour",
                                  groupValue: hour,
                                  onChanged: (value) {
                                    setState(() {
                                      hour = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: LightColors.kPalePink,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: RadioListTile(
                                  title: Text("4 Hour"),
                                  value: "4 Hour",
                                  groupValue: hour,
                                  onChanged: (value) {
                                    setState(() {
                                      hour = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*DropdownButtonFormField(
                              //hint: Text('1 Hour'),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.timelapse_rounded),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.grey)),
                              ),
          
                              // Initial Value
                              value: selectedHour,
          
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
          
                              // Array list of items
                              items: items3.map((String items3) {
                                return DropdownMenuItem(
                                  
                                  value: items3,
                                  child: Text(items3),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedHour = newValue!;
                                });
                              },
                            ),*/

                        /*SizedBox(
                            //height: 100,
                            child: DropdownButtonFormField(
                              hint: Text('1 Hour'),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.timelapse_rounded),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.grey)),
                              ),
          
                              // Initial Value
                              value: selectedHour,
          
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
          
                              // Array list of items
                              items: items3.map((String items3) {
                                return DropdownMenuItem(
                                  
                                  value: items3,
                                  child: Text(items3),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedHour = newValue!;
                                });
                              },
                            ),
                          ),*/
                        SizedBox(height: 10),
                        /*SizedBox(
                            child: DropdownButtonFormField(
                              hint: Text('Rest'),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.home_max_rounded),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.grey)),
                              ),
          
                              // Initial Value
                              value: selectedActivityType,
          
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
          
                              // Array list of items
                              items: items1.map((String items1) {
                                return DropdownMenuItem(
                                  value: items1,
                                  child: Text(items1),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedActivityType = newValue!;
                                });
                              },
                            ),
                          ),*/
                        SizedBox(height: 10),
                        /*SizedBox(
                            //height: 100,
                            child: DropdownButtonFormField(
                              hint: Text('Every Day'),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.sunny),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.grey)),
                              ),
          
                              // Initial Value
                              value: selectedRate,
          
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
          
                              // Array list of items
                              items: items2.map((String items2) {
                                return DropdownMenuItem(
                                  value: items2,
                                  child: Text(items2),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRate = newValue!;
                                });
                              },
                            ),
                          ),*/
                        DropdownButtonFormField(
                          hint: Text('Rest'),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.home_max_rounded),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                          ),
                          value: "Rest",
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items1.map((String items1) {
                            return DropdownMenuItem(
                              value: items1,
                              child: Text(items1),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedActivityType = newValue!;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField(
                          hint: Text('Rate'),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.sunny),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items2.map((String items2) {
                            return DropdownMenuItem(
                              value: items2,
                              child: Text(items2),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRate = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 355,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        //padding: EdgeInsets.only(right: 50)
                      ),
                      onPressed: () {
                        addActivityTime(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TimetableWeek()), //next page study time
                        );
                        //addTimeTable(context);
                      },
                      child: const Text(
                        'GENERATE STUDY PLAN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  /*SizedBox(
                    width: 176,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(143, 255, 255, 255),
                        //padding: EdgeInsets.only(right: 50)
                      ),
                      onPressed: () {
                        //addSubject(context);
                        //addPersonalData(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TimetableStudent()), //next page study time
                        );
                      },
                      child: const Text(
                        'BACK',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.check),
      //   label: Text('Done'),
      //   backgroundColor: LightColors.kGreen,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
      //   onPressed: () {
      //     addActivityTime(context);
      //     setState(() {
      //       activity_name.clear();
      //       //emailFieldController.clear();
      //       //addressFieldController.clear();
      //     });
      //     _showSuccess(context);
      //   },
      // ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Information"),
        content: new Text("Activity time - "),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          // <-- SEE HERE
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
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
                  leading: Icon(Icons.table_chart_rounded),
                  title: Text('Activity list'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // builder: (context) => ListActivityTime(userId: 'D09'),
                        builder: (context) => ListActivityTime(),
                      ),
                    );
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                       // builder: (context) => ListActivityTime(userId: 'D09'),
                        builder: (context) => ListActivityTime(),
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
