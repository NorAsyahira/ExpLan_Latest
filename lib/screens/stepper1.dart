//import 'dart:html';

import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../dates_list.dart';
import '../theme/colors/light_colors.dart';
import '../widgets/back_button.dart';
import '../widgets/calendar_dates1.dart';

class CheckoutPage1 extends StatefulWidget {
  const CheckoutPage1({Key? key}) : super(key: key);

  @override
  State<CheckoutPage1> createState() => _CheckoutPage1State();
}

class _CheckoutPage1State extends State<CheckoutPage1> {
  static const _steps = [
    Step(
      title: Text('Personal Data'),
      content: _PersonalDataForm(),
    ),
    Step(
      title: Text('Subject'),
      content: _SubjectForm(),
    ),
    Step(
      title: Text('Study Time'),
      content: _StudyTimeForm(),
    )
  ];

  int _currentStep = 0;

  _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  _steps1() => [
        Step(
          title: const Text('Personal Data'),
          content: const _PersonalDataForm(),
          state: _stepState(0),
          isActive: _currentStep == 0,
        ),
        Step(
          title: const Text('Subject'),
          content: const _SubjectForm(),
          state: _stepState(1),
          isActive: _currentStep == 1,
        ),
        Step(
          title: const Text('Study Time'),
          content: const _StudyTimeForm(),
          state: _stepState(2),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        elevation: 0,

        //title: const Text('Data'),
      ),
      body: Stepper(
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controls.onStepContinue,
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,

                        // NEW
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (_currentStep != 0)
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          //padding: EdgeInsets.only(right: 50)
                        ),
                        onPressed: controls.onStepCancel,
                        child: const Text(
                          'BACK',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        type: StepperType.horizontal,
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: () {
          setState(() {
            if (_currentStep < _steps.length - 1) {
              _currentStep += 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        currentStep: _currentStep,
        steps: _steps1(),
      ),
    );
  }
}

class _PersonalDataForm extends StatefulWidget {
  const _PersonalDataForm({Key? key}) : super(key: key);

  @override
  State<_PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<_PersonalDataForm> {
  TextEditingController username = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController university = TextEditingController();

  Future addPersonalData(context) async {
    var data = {
      'username': username.text,
      'birthday': birthday.text,
      'gender': gender.text,
      'course': course.text,
      'university': university.text,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/storePersonalData'),
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

  @override
  void initState() {
    birthday.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Personal Data',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 50),
            ]),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Privacy section',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
        /*TextFormField(
          decoration: const InputDecoration(
            labelText: 'Street',
          ),
        ),*/

        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
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
              TextFormField(
                controller: gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.male_rounded),
                ),
              ),
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
              ElevatedButton(
                  onPressed: () {
                    addPersonalData(context);
                  },
                  child: Text('Done')),
            ],
          ),
        ),
      ],
    );
  }
}

class _SubjectForm extends StatefulWidget {
  const _SubjectForm({Key? key}) : super(key: key);

  @override
  State<_SubjectForm> createState() => _SubjectFormState();
}

class _SubjectFormState extends State<_SubjectForm> {
  TextEditingController subject_name = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController start_time = TextEditingController();
  TextEditingController end_time = TextEditingController();
  TextEditingController description = TextEditingController();

  Future addSubject(context) async {
    var data = {
      'subject_name': subject_name.text,
      'day': day.text,
      'start_time': start_time.text,
      'end_time': end_time.text,
      'description': description.text,
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
  }

  //List<_SubjectForm> subjects = [];
  int _count = 0;

  @override
  void initState() {
    start_time.text = "";
    end_time.text = "";
    super.initState();
    _count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Subject Data',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                //SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _count++;
                      });
                    },
                    child: Text('Add Subject')),
              ]),*/
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Subject list based on timetable',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
          ),
          //SizedBox(height: 20.0),
          Expanded(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _count,
                itemBuilder: (context, index) {
                  //return _form(index);
                  return Container();
                },
              ),
            ),
          ),
          /*TextFormField(
            controller: subject_name,
            //initialValue: 'Input text',
            decoration: InputDecoration(
              labelText: 'Title',
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
            controller: day,
            //initialValue: 'Input text',
            decoration: InputDecoration(
              labelText: 'Day',
              //errorText: 'Error message',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_month_rounded),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ),
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
          TextFormField(
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
          ),
          /*TextFormField(
            decoration: const InputDecoration(
              labelText: 'Expiry date',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'CVV',
            ),
          ),*/
          SizedBox(height: 10),
          SizedBox(
            width: 400,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                addSubject(context);
              },
              child: const Text(
                'SUBMIT',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
    
                // NEW
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  _form(index) {
    return Column(
      children: [
        TextFormField(
          //initialValue: 'Input text',
          decoration: InputDecoration(
            labelText: 'Title',
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
          //initialValue: 'Input text',
          decoration: InputDecoration(
            labelText: 'Day',
            //errorText: 'Error message',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.calendar_month_rounded),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: TextFormField(
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
                        //timeinputstart.text =
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
                        //timeinputstart.text =
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
        TextFormField(
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
        ),
        SizedBox(height: 40),
        DottedLine(),
        SizedBox(height: 40),
      ],
    );
  }
}

class _StudyTimeForm extends StatefulWidget {
  const _StudyTimeForm({Key? key}) : super(key: key);

  @override
  State<_StudyTimeForm> createState() => _StudyTimeFormState();
}

class _StudyTimeFormState extends State<_StudyTimeForm> {
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

    /*showDialog<String>(
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
    );*/
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
    return Column(
      children: [
        Column(
          children: <Widget>[
            //MyBackButton(),
            //SizedBox(height: 30.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                Widget>[
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
          ],
        ),
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
            /*Container(
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
            ),*/
          ],
        ),

        //Center(child: Text('Thank you for your order!')),
      ],
    );
  }
}
