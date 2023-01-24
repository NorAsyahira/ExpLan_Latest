import 'package:flutter/material.dart';
import 'package:time2study/screens/add_subject_page%20.dart';
import 'package:time2study/screens/calendar_page.dart';
import 'package:time2study/screens/calender/calendar.dart';
import 'package:time2study/screens/calender/calendar_view.dart';
import 'package:time2study/screens/calender/dynamic_events.dart';
import 'package:time2study/screens/calender/testCalendar.dart';
import 'package:time2study/screens/calender/timetable_display.dart';
import 'package:time2study/screens/calender/timetable_week.dart';
import 'package:time2study/screens/calender/topCalendar.dart';
import 'package:time2study/screens/create_new_task_page.dart';
import 'package:time2study/screens/dynamic_form.dart';
import 'package:time2study/screens/formData/activity_time.dart';
import 'package:time2study/screens/formData/create_task.dart';
import 'package:time2study/screens/formData/personalData.dart';
import 'package:time2study/screens/formData/studyTime.dart';
import 'package:time2study/screens/formData/timetable.dart';
import 'package:time2study/screens/signup/bottom_nav.dart';
import 'package:time2study/screens/signup/home_page.dart';
import 'package:time2study/screens/home_page1.dart';
import 'package:time2study/screens/splash%20screen/splash_personal_data.dart';
import 'package:time2study/screens/view%20list/listPersonalData.dart';
import 'package:time2study/screens/signup/login_page.dart';
import 'package:time2study/screens/personal_data_page.dart';
import 'package:time2study/screens/personal_data_page1.dart';
import 'package:time2study/screens/quiz/components/topQuestionNum.dart';
import 'package:time2study/screens/quiz/quiz_screen.dart';
import 'package:time2study/screens/signup/signUp_page.dart';
import 'package:time2study/screens/signup/splash_page.dart';
import 'package:time2study/screens/stepper.dart';
import 'package:time2study/screens/stepper1.dart';
import 'package:time2study/screens/study_time_page.dart';
import 'package:time2study/screens/test.dart';
import 'package:time2study/screens/todo.dart';
import 'package:time2study/screens/view%20list/listActivityTime.dart';
import 'package:time2study/screens/view%20list/listTimetable.dart';
import 'package:time2study/theme/colors/light_colors.dart';
import 'package:time2study/screens/formData/subject_form.dart';
import 'package:time2study/todo_list/todo_assignment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: LightColors.kLightYellow,
        primarySwatch: Colors.red,
        //scaffoldBackgroundColor: Colors.tealAccent,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'),
      ),
      //home: HomePage(),
      //home: SubjectForm1(),
      //home: TodoPage(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
