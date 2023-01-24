import 'package:flutter/material.dart';

class TopQuestionNumber extends StatelessWidget {
  //const TopQuestionNumber({super.key});

  int step;

  TopQuestionNumber({
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: 40,
                width: 30,
                decoration: BoxDecoration(
                  color: this.step == 1? Colors.redAccent : Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Align(
                  child: Text('1', style: TextStyle(
                    fontSize: 30,
                    
                  ),),
              ),
              ),
              Container(
                height: 40,
                width: 30,
                decoration: BoxDecoration(
                  color: this.step == 1? Colors.redAccent : Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Align(
                  child: Text('1', style: TextStyle(
                    fontSize: 30,
                    
                  ),),
              ),
              ),

            ],
           
          ),
        ),
        /*Text.rich(
          TextSpan(  
            style: TextStyle(

              color: this.step == 1?Colors.redAccent : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),

            children: [
              WidgetSpan(
                child: Icon(Icons.question_answer_rounded, 
                size: 20,
                color: this.step == 1?Colors.redAccent : Colors.black54)),
              TextSpan(text: '  Questionnaire'),
            ],
          ),
        ),
        SizedBox(width: 5),
        Text.rich(
          TextSpan(  
            style: TextStyle(

              color: this.step == 2?Colors.redAccent : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),

            children: [
              WidgetSpan(
                child: Icon(Icons.book_rounded, 
                size: 20,
                color: this.step == 2?Colors.redAccent : Colors.black54)),
              TextSpan(text: ' Timetable'),
            ],
          ),
        ),
        SizedBox(width: 5),
        Text.rich(
          TextSpan(
             
            style: TextStyle(

              color: this.step == 3?Colors.redAccent : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),

            children: [
              WidgetSpan(
                child: Icon(Icons.timelapse, 
                size: 20,
                color: this.step == 3?Colors.redAccent : Colors.black54)),
              TextSpan(text: ' Activity Time'),
            ],
          ),
        ),*/
      ],
    );
  }
}