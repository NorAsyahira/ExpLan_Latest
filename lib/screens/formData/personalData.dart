import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time2study/screens/formData/studyTime.dart';
import 'package:time2study/screens/formData/subject_form.dart';
import 'package:time2study/screens/formData/timetable.dart';
import 'package:time2study/screens/signup/bottom_nav.dart';
import 'package:time2study/screens/signup/home_page.dart';

import '../../theme/colors/light_colors.dart';
import '../../widgets/back_button.dart';
import '../../widgets/stepper.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  TextEditingController username = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController university = TextEditingController();
  TextEditingController time_wakeup = TextEditingController();
  TextEditingController time_sleep = TextEditingController();
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //String? email;
  int? user_id;

  Future getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getInt("user_id");
    });
  }

  Future addPersonalData(context) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = {
      'username': username.text,
      'birthday': birthday.text,
      'gender': gender1,
      'course': course.text,
      'university': university.text,
      'time': selectedTime,
      'times_a_day': selectedMany,
      'time_wakeup': time_wakeup.text,
      'time_sleep': time_sleep.text,
      'user_id': user_id,
    };
    //print(data);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/storePersonalData'),
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
    birthday.text = "";
    time_wakeup.text = "";
    time_sleep.text = "";
    selectedTime;
    selectedMany;
    gender1;
    getSharedPrefs();
    //set the initial value of text field
    super.initState();
  }

  List<String> items = ['Day', 'Night'];
  List<String> items1 = ['1 times a day', '2 times a day', '3 times a day'];
  List<String> items2 = ['Male'];

  String? selectedTime = 'Day';
  String? selectedMany = '1 times a day';

  String? gender1;
  //String gender2 = 'female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    MyBackButton(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Personal Data',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    /*IconButton(
                        onPressed: () {
                          _showDialog(context);
                        },
                        icon: Icon(Icons.question_mark_outlined, size: 20))*/
                    IconButton(
                        onPressed: () {
                          _showMoreVert(context);
                        },
                        icon: Icon(Icons.more_vert_rounded)),
                  ],
                ),
                SizedBox(height: 40),
                TopStepper(step: 1),
                SizedBox(height: 40),
                Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Personal Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: username,
                      //initialValue: 'Input text',
                      decoration: InputDecoration(
                        labelText: 'Username',
                        //errorText: 'Error message',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.edit),
                        /*suffixIcon: Icon(
                            Icons.error,
                          ),*/
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: birthday,
                      decoration: const InputDecoration(
                        labelText: 'Birthday',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month_rounded),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            birthday.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Gender',
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
                                color: LightColors.kDarkYellow,
                                borderRadius: BorderRadius.circular(9)),
                            child: RadioListTile(
                              title: Text("Male"),
                              value: "male",
                              groupValue: gender1,
                              onChanged: (value) {
                                setState(() {
                                  gender1 = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: LightColors.kDarkYellow,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: RadioListTile(
                              title: Text("Female"),
                              value: "female",
                              groupValue: gender1,
                              onChanged: (value) {
                                setState(() {
                                  gender1 = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*TextFormField(
                      controller: gender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.male_rounded),
                      ),
                    ),*/
                    /*DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
          
                        child: Padding(
                          padding: EdgeInsets.only(left:30, right:30),
                          child: DropdownButton(
                           
                          // Initial Value
                          value: dropdownvalue,
                           
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
                              dropdownvalue = newValue!;
                            });
                          },
                          
                          ),
                        ),
                      ),*/
                    Row(
                      children: <Widget>[
                        /*Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white, // Background color
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.man_rounded,
                                        size: 72,
                                        color: Colors.black45,
                                      ),
                                      Text(
                                        'Male',
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            /*child: GestureDetector(
                              
                              onTap: (() {}),
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.man_rounded, size: 75),
                                    Text(
                                      'Male',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),*/
                          ),*/

                        SizedBox(
                          width: 10,
                        ),

                        /*Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              
                              /*child: ElevatedButton(
                                  
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white, // Background color
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.girl_rounded,
                                        size: 80,
                                        color: Colors.black45,
                                      ),
                                      Text(
                                        'Female',
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  )),*/
                              child: Radio(
                                  value: 'female',
                                  groupValue: _gender,
                                  onChanged: _valueChangedHandler()),
                            ),
                          ),*/
                        /*Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.girl_rounded, size: 80),
                                    Text(
                                      'Female',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),*/
                      ],
                    ),
                    //SizedBox(height: 10),
                    /*TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                           border: OutlineInputBorder(),
                        ),
                      ),*/

                    SizedBox(height: 10),
                    TextFormField(
                      controller: course,
                      decoration: const InputDecoration(
                        labelText: 'Course',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.book),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: university,
                      decoration: const InputDecoration(
                        labelText: 'University',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school_rounded),
                      ),
                    ),
                    SizedBox(height: 40),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Preferred Study Time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                          prefixIcon: Icon(Icons.calendar_month_rounded)),
                      value: selectedTime,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTime = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                          prefixIcon: Icon(Icons.timelapse_rounded)),
                      value: selectedMany,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items1.map((String items1) {
                        return DropdownMenuItem(
                          value: items1,
                          child: Text(items1),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMany = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 40),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sleeping Routine',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                                controller: time_wakeup,
                                //initialValue: 'Input text',
                                decoration: InputDecoration(
                                  labelText: 'Time wakeup',
                                  //errorText: 'Error message',
                                  border: OutlineInputBorder(),
                                  prefixIcon:
                                      Icon(Icons.calendar_month_rounded),
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
                                    print(pickedTime
                                        .format(context)); //output 10:51 PM
                                    DateTime parsedTime = DateFormat.jm().parse(
                                        pickedTime.format(context).toString());
                                    //converting to DateTime so that we can further format on different pattern.
                                    print(
                                        parsedTime); //output 1970-01-01 22:53:00.000
                                    String formattedTime =
                                        DateFormat('HH:mm:ss')
                                            .format(parsedTime);
                                    print(formattedTime); //output 14:59:00
                                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                                    setState(() {
                                      time_wakeup.text =
                                          formattedTime; //set the value of text field.
                                    });
                                  } else {
                                    print("Time is not selected");
                                  }
                                })),
                        SizedBox(width: 20),
                        Expanded(
                            child: TextFormField(
                                controller: time_sleep,
                                //initialValue: 'Input text',
                                decoration: InputDecoration(
                                  labelText: 'Time sleep',
                                  //errorText: 'Error message',
                                  border: OutlineInputBorder(),
                                  prefixIcon:
                                      Icon(Icons.calendar_month_rounded),
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
                                    print(pickedTime
                                        .format(context)); //output 10:51 PM
                                    DateTime parsedTime = DateFormat.jm().parse(
                                        pickedTime.format(context).toString());
                                    //converting to DateTime so that we can further format on different pattern.
                                    print(
                                        parsedTime); //output 1970-01-01 22:53:00.000
                                    String formattedTime =
                                        DateFormat('HH:mm:ss')
                                            .format(parsedTime);
                                    print(formattedTime); //output 14:59:00
                                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                                    setState(() {
                                      time_sleep.text =
                                          formattedTime; //set the value of text field.
                                    });
                                  } else {
                                    print("Time is not selected");
                                  }
                                })),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 370,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: LightColors.kRed,
                              //padding: EdgeInsets.only(right: 50)
                            ),
                            onPressed: () {
                              //addSubject(context);
                              addPersonalData(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNav()),
                              );
                            },
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.check),
        label: Text('Done'),
        backgroundColor: LightColors.kGreen,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        onPressed: () {
          addPersonalData(context);
          //username.clear();
          //birthday.clear();
          //course.clear();
          //university.clear();
          //time_wakeup.clear();
          //time_sleep.clear();
          _showSuccess(context);
        },
      ),*/
    );
  }
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
