import 'package:flutter/material.dart';

class CalendarDates1 extends StatelessWidget {
  final String day;
  //final String date;
  final Color dayColor;
  //final Color dateColor;

  CalendarDates1({required this.day, required this.dayColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            day,
            style: TextStyle(
                fontSize: 16, color: dayColor, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10.0),
          
        ],
      ),
    );
  }
}