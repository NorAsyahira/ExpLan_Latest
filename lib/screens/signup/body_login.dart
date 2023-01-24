import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time2study/screens/formData/personalData.dart';
import 'package:time2study/screens/signup/bottom_nav.dart';
import 'package:time2study/screens/signup/login_page.dart';
import 'package:time2study/screens/signup/signUp_page.dart';

import 'home_page.dart';
import '../../theme/colors/light_colors.dart';

class Body_Login extends StatefulWidget {
  const Body_Login({super.key});

  @override
  State<Body_Login> createState() => _Body_LoginState();
}

class _Body_LoginState extends State<Body_Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future login(context) async {
    final SharedPreferences prefs = await _prefs;
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
      },
    );

    final responseString = json.decode(response.body);
    print(responseString['user']['email']);
    print(responseString);
    if (responseString['status'] == 'Success') {
      await prefs.remove('user_id');
      prefs.setInt('user_id', responseString['user']['user_id']);
      prefs.setString('email', responseString['user']['email']);
      //  prefs.setString('email', counter),
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
              if (responseString['user']['isCompleted'] == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PersonalData()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNav()));
              }
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
                "Successful Login!",
                textAlign: TextAlign.center,
              ),
            );
          });
      /*showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success Login'),
          //content: Text(responseString['message']),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
                /*Navigator.of(context).pushNamedAndRemoveUntil(
                    'home_page', (Route<dynamic> route) => false);*/
              },
            ),
          ],
        ),
      );*/
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Failed'),
          content: Text(responseString['message']),
          actions: <Widget>[
            TextButton(
              child: const Text('Try Again'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 20,
            width: 330,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                        child: Image.asset(
                      'assets/images/login.png',
                      height: 300,
                      width: 300,
                      fit: BoxFit.fitWidth,
                    )),
                  ),*/
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: LightColors.kLightYellow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 250,
                  top: 40,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'DMSerifDisplay',
                    fontSize: 35.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    //color: Colors.brown.shade50,
                    //color: Colors.teal.shade900,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 50, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 30,),
                //padding: EdgeInsets.all(30),

                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(width: 18, color: Colors.deepPurple)),
                    labelText: 'Email',
                    //hintText: 'Enter valid email id as abc@gmail.com',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: 0),
                //padding: EdgeInsets.all(30),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Password',
                    //hintText: 'Enter valid email id as abc@gmail.com',
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  login(context); //do something
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(350, 55)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),

                  //elevation: MaterialStateProperty.all(15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                ],
              )

              /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: () {
                        //do something
                      }, 
                      child: Text('Forget Password?'),
                      ),
                    ],
                  ),*/
            ]),
          ),
        ),
      ],
    );
  }
}
