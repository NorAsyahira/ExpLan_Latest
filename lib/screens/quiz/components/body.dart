import 'package:flutter/material.dart';
import 'package:time2study/widgets/top_container.dart';

import '../../../theme/colors/light_colors.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: Column(
                children: [

                ],
              ),
            )),
            Expanded(
            flex: 10,
            child: Container(
              color: Colors.white,
            ))
        ],
      ));
  }
}
