import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:intl/intl.dart';
import 'package:time2study/widgets/date_picker.dart';

import '../theme/colors/light_colors.dart';
import '../widgets/back_button.dart';
import '../widgets/my_text_field.dart';
import '../widgets/top_container.dart';
import 'signup/home_page.dart';
import 'home_page1.dart';
import 'package:http/http.dart' as http;

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPage();
}

class _PersonalDataPage extends State<PersonalDataPage> {
 TextEditingController username = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController university = TextEditingController();

  Future addSubject(context) async {
    var data = {
      'username': username.text,
      'birthday': birthday.text,
      'gender': gender.text,
      'university': university.text,
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

    @override
    void initState() {
      birthday.text = ""; //set the initial value of text field
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
                        'Personal Data',
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
                        controller: username,
                        label: 'Username',
                        icon: Icon(Icons.search),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: birthday,
                              decoration: InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.calendar_today_rounded),
                                  labelText: 'Birthday'),
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
                                        birthday.text =
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
            SizedBox(height: 10),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  
                  //SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: university,
                          icon: Icon(Icons.collections_bookmark_rounded),
                          label: 'University',
                          minLines: 3,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          controller: gender,
                          icon: Icon(Icons.border_color_rounded),
                          label: 'Gender',
                          minLines: 3,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  /*Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 0, top:10, right: 200, bottom:0),
                        child: Text(
                          'Choose Your Gender',
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17.0),
                          ),
                       ),
                       getWidget(true, false),
                       //Divider(thickness: 10.0,),
                    ],
                  ),*/
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
                  
                ],
              ),
            )),
            Container(
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
                        'Submit',
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
            ),
            
          ],
        ),
      ),
    );
  }
  Widget getWidget(bool showOtherGender, bool alignVertical) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: showOtherGender,
        verticalAlignedText: alignVertical,
        
        // to show what's selected on app opens, but by default it's Male
        selectedGender: Gender.Male,
        selectedGenderTextStyle: TextStyle(
            color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          print(gender);
        },
        //Alignment between icons
        equallyAligned: true,
        
        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(3),
        size: 50, //default : 40
      ),
    );
  }
}
