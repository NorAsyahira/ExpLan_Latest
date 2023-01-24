import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time2study/widgets/date_picker.dart';
import 'package:time2study/widgets/list_subject.dart';

import '../theme/colors/light_colors.dart';
import '../widgets/back_button.dart';
import '../widgets/my_text_field.dart';
import '../widgets/top_container.dart';
import 'signup/home_page.dart';
import 'home_page1.dart';
import 'package:http/http.dart' as http;

class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({super.key});

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  TextEditingController title = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinputstart = TextEditingController();
  TextEditingController timeinputend = TextEditingController();
  TextEditingController description = TextEditingController();

  Future addSubject(context) async {
    var data = {
      'subject_name': title.text,
      'date': dateInput.text,
      'start_time': timeinputstart.text,
      'end_time': timeinputend.text,
      'description': description.text
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
                  '/home_page', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );

    @override
    void initState() {
      dateInput.text = ""; //set the initial value of text field
      timeinputstart.text = "";
      timeinputend.text = "";
      super.initState();
    }
  }

  //DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              height: 300,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Add Subject',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(
                        controller: title,
                        label: 'Title',
                        icon: Icon(Icons.search),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: dateInput,
                              decoration: InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.calendar_today_rounded),
                                  labelText: 'Enter Date'),
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
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                            /*child: MyTextField(
                              label: 'Date',
                              icon: downwardIcon,
                              
                            ),*/
                            /*child: Text(
                              _dateTime.toString(),
                              //_dateTime.toString(),
                            ),*/
                          ),
                          //HomePage.calendarIcon(),
                          //DatePicker(),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        /*child: MyTextField(
                        label: 'Start Time',
                        icon: downwardIcon,
                      )*/
                        child: TextField(
                            controller: timeinputstart, //editing controller of this TextField
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons
                                    .timelapse_rounded), //icon of text field
                                labelText: "Start Time" //label text of field
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
                                  timeinputstart.text =
                                      formattedTime; //set the value of text field.
                                });
                              } else {
                                print("Time is not selected");
                              }
                            }),
                      ),
                      SizedBox(width: 40),
                      Expanded(
                        /*child: MyTextField(
                          label: 'End Time',
                          icon: Icon(Icons.timelapse_rounded),
                          
                        ),*/
                        child: TextField(
                          controller: timeinputend, //editing controller of this TextField
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                  Icons.timelapse_rounded), //icon of text field
                              labelText: "End Time" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(
                                  pickedTime.format(context)); //output 10:51 PM
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.
                              print(
                                  parsedTime); //output 1970-01-01 22:53:00.000
                              String formattedTime =
                                  DateFormat('HH:mm:ss').format(parsedTime);
                              print(formattedTime); //output 14:59:00
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              setState(() {
                                timeinputend.text = formattedTime; //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    controller: description,
                    icon: Icon(Icons.search),
                    label: 'Description',
                    minLines: 3,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),
                  /*Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          //direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 0,
                          //textDirection: TextDirection.rtl,
                          spacing: 10.0,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                                label: Text("STUDY"),
                                backgroundColor: LightColors.kRed,
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },

                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                                label: Text("ASSIGNMENT"),
                                shadowColor: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },

                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                                label: Text("FREE TIME"),
                                shadowColor: Colors.black,
                                
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },

                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                                label: Text("NOTES"),
                                shadowColor: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },

                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                                label: Text("GAMING PLATFORM APP"),
                                shadowColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )*/
                  SizedBox(height: 10),
                  /*Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(
                    'Subject List',
                    textAlign: TextAlign.start,
                     style: TextStyle(
                     fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),*/
                  //ListSubject(),
                ],
              ),
            )),
            /*Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      addSubject(context);
                      //Navigator.pop(context);
                    },
                    child: Container(
                      child: Text(
                        'Add Subject',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        color: LightColors.kRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                child: Text('Add Subject'),
                onPressed: () {
                  addSubject(context);
                  // Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
