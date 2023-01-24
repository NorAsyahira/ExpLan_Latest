import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/colors/light_colors.dart';
import '../../widgets/back_button.dart';
import '../../widgets/stepper.dart';
import '../../widgets/top_container.dart';
import '../signup/home_page.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  get width => null;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: LightColors.kLightYellow,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          //margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(children: [
                Text(
                  'New Task',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 50),
                //ElevatedButton(onPressed: () {}, child: Text('+  Study Time')),
              ]),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create new task',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                //controller: day,
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
                          //controller: time_from,
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
                                //time_from.text =
                                formattedTime; //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          })),
                  SizedBox(width: 10),
                  Expanded(
                      child: TextFormField(
                          //controller: time_to,
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
                                //time_to.text =
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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100)
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
                    //addStudyTime(context);
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Success Created'),
                              content: const Text(
                                  'Do you want to add another study time?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Add Study Time'),
                                  onPressed: () {
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StudyTime()),
                                    );*/
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
                    /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SubjectForm1()),
                          );*/
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
