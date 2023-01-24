import 'package:flutter/material.dart';

import '../../theme/colors/light_colors.dart';
import 'body_signup.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      backgroundColor: LightColors.kDarkYellow,
      body: Body_SignUp(),
    );
  }
}
