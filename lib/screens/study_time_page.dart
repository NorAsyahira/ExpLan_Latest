import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time2study/widgets/calendar_dates1.dart';

import '../dates_list1.dart';
import '../theme/colors/light_colors.dart';
import '../widgets/back_button.dart';
import '../widgets/calendar_dates.dart';
import 'package:http/http.dart' as http;

class StudyTimePage extends StatefulWidget {
  const StudyTimePage({super.key});

  @override
  State<StudyTimePage> createState() => _StudyTimePageState();
}

class _StudyTimePageState extends State<StudyTimePage> {
  TextEditingController timeinputfrom = TextEditingController();
  TextEditingController timeinputto = TextEditingController();

  Future addSubject(context) async {
    var data = {
      'start_time': timeinputfrom.text,
      'end_time': timeinputto.text,
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
                  '/home', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );

    int _count = 0;

    @override
    void initState() {
      //set the initial value of text field
      timeinputto.text = "";
      timeinputfrom.text = "";
      super.initState();
      _count = 0;
    }
  }

  String dropdownvalue = 'Monday';

  var items = [
    'Tuesday',
    'Wenesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                0,
              ),
              child: Column(children: <Widget>[
                MyBackButton(),
                SizedBox(height: 30.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Study Time',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 50),
                    ]),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Productive Day',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 58.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CalendarDates1(
                        day: days[index],
                        //date: dates[index],
                        dayColor:
                            index == 0 ? LightColors.kRed : Colors.black54,
                      );
                    },
                  ),
                ),
                Divider(thickness: 5),
                SizedBox(height: 10),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Day',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(),
                      /*child: DropdownButton(
                      // Initial Value
                     value: dropdownvalue,
                     icon: const Icon(Icons.keyboard_arrow_down),  
                      items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                      onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },),*/
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Normal time',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    //ElevatedButton(onPressed: () {}, child: Text('Add Time'))
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: LightColors.kRed,
                        shape: RoundedRectangleBorder( 
                          borderRadius: BorderRadius.circular(10)
                      )),
                      onPressed: () {}, 
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 10),
                          Text('Add time'),
                        ],
                      ))
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextField(
                                controller: timeinputfrom,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons
                                        .timelapse_rounded), //icon of text field
                                    labelText: "From" //label text of field
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
                                      timeinputfrom.text =
                                          formattedTime; //set the value of text field.
                                    });
                                  } else {
                                    print("Time is not selected");
                                  }
                                })),
                        SizedBox(width: 40),
                        Expanded(
                            child: TextField(
                                controller: timeinputto,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons
                                        .timelapse_rounded), //icon of text field
                                    labelText: "To" //label text of field
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
                                      timeinputto.text =
                                          formattedTime; //set the value of text field.
                                    });
                                  } else {
                                    print("Time is not selected");
                                  }
                                })),
                      ],
                    ),
                  ),
                ),
                /*ElevatedButton(
                onPressed: () {}, 
                child: Text('Submit'))*/
              ]))),
    );
  }
}
