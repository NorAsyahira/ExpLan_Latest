import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:time2study/screens/formData/personalData.dart';
import 'package:time2study/screens/signup/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time2study/screens/signup/login_page.dart';

import '../../theme/colors/light_colors.dart';

class Body_SignUp extends StatefulWidget {
  const Body_SignUp({super.key});

  @override
  State<Body_SignUp> createState() => _Body_SignUpState();
}

class _Body_SignUpState extends State<Body_SignUp> {
  //TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future register(context) async {
    var data = {
      //'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/registration'),
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
          builder: (context) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PersonalData()));
              /*Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage()));*/
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
                "Successful Register!",
                textAlign: TextAlign.center,
              ),
            );
          });
      /*showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success Register'),
          content: Text(responseString['message']),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));*/
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'home_page', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      );*/
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Failed Register!'),
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
            height: 10,
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signup.png"),
                fit: BoxFit.fitWidth,
              ),
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
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 200,
                    top: 30,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'DMSerifDisplay',
                      fontSize: 35.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      //color: Colors.yellow.shade600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                /*Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 0, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 30,),
                  //padding: EdgeInsets.all(30),

                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Username',
                      //hintText: 'Enter valid email id as abc@gmail.com',
                    ),
                  ),
                ),*/
                //SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 30, bottom: 0),
                  //padding: EdgeInsets.all(30),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                      //labelText: 'Confirm Password',
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
                    /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );*/
                    register(context);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );*/
                    _showSuccess(context);

                    //do something
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(350, 55)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    //backgroundColor: Color.fromARGB(255, 205, 84, 75),

                    //elevation: MaterialStateProperty.all(15),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                ),
              ]),
            ),
          ),
        ),
      ],
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
            "Successful Register!",
            textAlign: TextAlign.center,
          ),
        );
      });
}
