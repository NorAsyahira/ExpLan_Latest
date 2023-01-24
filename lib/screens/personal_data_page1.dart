import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:intl/intl.dart';
import 'package:time2study/widgets/date_picker.dart';

import '../model/personalDataModel.dart';
import '../theme/colors/light_colors.dart';
import '../widgets/back_button.dart';
import '../widgets/my_text_field.dart';
import '../widgets/top_container.dart';
import 'signup/home_page.dart';
import 'home_page1.dart';
import 'package:http/http.dart' as http;

class PersonalDataPage1 extends StatefulWidget {
  const PersonalDataPage1({super.key});

  @override
  State<PersonalDataPage1> createState() => _PersonalDataPage1();
}

class _PersonalDataPage1 extends State<PersonalDataPage1> {
  TextEditingController username = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController university = TextEditingController();

  Future addPersonalData(context) async {
    var data = {
      'username': username.text,
      'birthday': birthday.text,
      'gender': gender.text,
      'university': university.text,
    };

    /*Future<http.Response> PersonalDataModel(String title) {
      return http.post(
        Uri.parse('http://10.0.2.2:8000/api/storePersonalData'),
        body: jsonEncode(data),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
          'Charset': 'utf-8',
        },
      );
      
    }*/

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/storePersonalData'),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
      },
    );
    final responseString = json.decode(response.body);
    print(responseString);
    if (responseString['status'] == 'Success') {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Data Stored!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home_page', (Route<dynamic> route) => false);
                      },
                      child: Text('OK'))
                ],
              ));
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Failed'),
          content: Text(responseString['message']),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

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

    @override
    void initState() {
      //dateInput.text = ""; //set the initial value of text field
      //timeinputstart.text = "";
      //timeinputend.text = "";
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
                      /*MyTextField(
                        controller: username,
                        label: 'Username',
                        icon: Icon(Icons.search),
                      ),*/
                      TextField(
                        controller: username,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      MyTextField(
                        controller: birthday,
                        label: 'Birthday',
                        icon: Icon(Icons.search),
                      ),
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
                          controller: gender,
                          icon: Icon(Icons.collections_bookmark_rounded),
                          label: 'Gender',
                          minLines: 3,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          controller: university,
                          icon: Icon(Icons.border_color_rounded),
                          label: 'University',
                          minLines: 3,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
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
                      addPersonalData(context);
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
}
