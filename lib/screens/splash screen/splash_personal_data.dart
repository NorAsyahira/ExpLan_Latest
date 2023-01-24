import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:time2study/screens/formData/personalData.dart';
import 'package:time2study/screens/home_page1.dart';
import 'package:time2study/screens/signup/login_page.dart';
import 'package:time2study/screens/signup/signUp_page.dart';
import 'package:time2study/widgets/back_button.dart';

import '../../theme/colors/light_colors.dart';

class SplashPersonalDataPage extends StatelessWidget {
  const SplashPersonalDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5),
          ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
              (context) => PersonalData(),
              ))
         );
    return Scaffold(
      backgroundColor: LightColors.kDarkYellow,
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20,20,20,20),
          //child: MyBackButton(),
        ),
      ),
      body: Column(
        children: [
          //SizedBox(height: 200),
          Image.asset(
            'assets/images/image6.png',
            height: 350,
            scale: 2.5,
            // color: Color.fromARGB(255, 15, 147, 59),
          ), //
          Center(
            child: Text(
              'Personal Data',
              style: GoogleFonts.lobster(
                textStyle: TextStyle(
                color: Colors.white,
                fontSize: 29,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),),
          /*SizedBox(height: 200),
          Center(
            child: LoadingAnimationWidget.discreteCircle(
                color: Colors.grey.shade200,
                size: 50,
                secondRingColor: LightColors.kRed,
                thirdRingColor: LightColors.kGreen),
          ),*/
        ],
      ),
      
      /*Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),),
                color: LightColors.kDarkYellow,
              ),
              width: MediaQuery.of(context).size.width,
              //color: LightColors.kDarkYellow,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                    height: 300,
                    scale: 2.5,
                        // color: Color.fromARGB(255, 15, 147, 59),
                   ),
                  Text('Personal Data') 
                ],
              ),
            )),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: [
                  Spacer(flex: 6),
                  ElevatedButton(
                    onPressed: () {

                    }, 
                    child: Text('Next',
                     style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                  ),),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(350, 55)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),

                  //elevation: MaterialStateProperty.all(15),
                ),),
                Spacer(flex: 1)

                ],
              ),
            )),
          
          /*SizedBox(height: 200),
          Image.asset(
            'assets/images/splash.png',
            height: 300,
            scale: 2.5,
            // color: Color.fromARGB(255, 15, 147, 59),
          ), //
          Center(
            child: Text(
              'Loading...',
              style: GoogleFonts.lobster(
                textStyle: TextStyle(
                color: Colors.white,
                fontSize: 29,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),),
          SizedBox(height: 200),
          Center(
            child: LoadingAnimationWidget.discreteCircle(
                color: Colors.grey.shade200,
                size: 50,
                secondRingColor: LightColors.kRed,
                thirdRingColor: LightColors.kGreen),
          ),*/
        ],
      ),*/
    );
  }
}
