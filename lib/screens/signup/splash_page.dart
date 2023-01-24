import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:time2study/screens/formData/personalData.dart';
import 'package:time2study/screens/home_page1.dart';
import 'package:time2study/screens/signup/login_page.dart';
import 'package:time2study/screens/signup/signUp_page.dart';

import '../../theme/colors/light_colors.dart';
import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            )));
    return Scaffold(
      backgroundColor: LightColors.kDarkYellow,
      body: Column(
        children: [
          SizedBox(height: 300),
          Image.asset(
            'assets/images/ex.png',
            height: 200,
            scale: 1.0,
            // color: Color.fromARGB(255, 15, 147, 59),
          ), //

          // SizedBox(
          //   height: 200,
          //   child: Center(
          //     child: Text(
          //       'ExpLan',
          //       style: GoogleFonts.lilitaOne(
          //         textStyle: TextStyle(
          //           color: Colors.blueAccent,
          //           fontSize: 40,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 200),
          Center(
            child: LoadingAnimationWidget.discreteCircle(
                color: Colors.grey.shade200,
                size: 50,
                secondRingColor: LightColors.kRed,
                thirdRingColor: LightColors.kGreen),
          ),
        ],
      ),
    );
  }
}
