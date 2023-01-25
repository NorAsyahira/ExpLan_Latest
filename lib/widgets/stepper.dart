import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class TopStepper extends StatelessWidget {
  int step;

  TopStepper({
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Text.rich(
        //   TextSpan(
        //     style: TextStyle(

        //       color: this.step == 1?Colors.redAccent : Colors.black54,
        //       fontWeight: FontWeight.w600,
        //       fontSize: 15,
        //     ),

        //     children: [
        //       WidgetSpan(
        //         child: Icon(Icons.question_answer_rounded,
        //         size: 20,
        //         color: this.step == 1?Colors.redAccent : Colors.black54)),
        //       TextSpan(text: '  Personal Data'),
        //     ],
        //   ),
        // ),
        // SizedBox(width: 5),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: this.step == 1 ? Colors.redAccent : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            children: [
              WidgetSpan(
                  child: Icon(Icons.book_rounded,
                      size: 20,
                      color:
                          this.step == 1 ? Colors.redAccent : Colors.black54)),
              TextSpan(text: ' Timetable'),
            ],
          ),
        ),
        SizedBox(width: 5),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: this.step == 2 ? Colors.redAccent : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            children: [
              WidgetSpan(
                  child: Icon(Icons.timelapse,
                      size: 20,
                      color:
                          this.step == 2 ? Colors.redAccent : Colors.black54)),
              TextSpan(text: ' Activity Time'),
            ],
          ),
        ),
        SizedBox(width: 5),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: this.step == 3 ? Colors.redAccent : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            children: [
              WidgetSpan(
                  child: Icon(Icons.calendar_month_rounded,
                      size: 20,
                      color:
                          this.step == 3 ? Colors.redAccent : Colors.black54)),
              TextSpan(text: ' Study Plan'),
            ],
          ),
        ),
      ],
    );
  }
}
