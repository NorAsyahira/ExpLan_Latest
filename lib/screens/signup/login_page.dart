import 'package:flutter/material.dart';

import '../../theme/colors/light_colors.dart';
import 'body_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kDarkYellow,
      resizeToAvoidBottomInset: false,
      body: Body_Login(),
    );
  }
}