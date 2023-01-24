import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time2study/screens/calendar_page.dart';
import 'package:time2study/screens/calender/timetable_week.dart';
import 'package:time2study/screens/create_new_task_page.dart';
import 'package:time2study/screens/formData/activity_time.dart';
import 'package:time2study/screens/formData/personalData.dart';
import 'package:time2study/screens/formData/timetable.dart';
import 'package:time2study/screens/signup/login_page.dart';

import '../../theme/colors/light_colors.dart';
import '../../widgets/active_project_card.dart';
import '../../widgets/task_column.dart';
import '../../widgets/top_container.dart';

class HomePage extends StatefulWidget {
  //const HomePage({super.key});
  /*Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }*/

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kRed,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int? userId;
  String? email;
  var _selectedTab = 0;

  late int _currentIndex;

  Future getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("email");
    });
  }

  Future logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("is_login");
      preferences.remove("email");
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const Login(),
      ),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  void onTabTapped(int index) {
    if (index == 2) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Login()));
    }
  }

  int _selectedIndex = 0;
  final widgetOptions = [
    HomePage(),
    TimetableStudent(),
  ];

  // int _selectedIndex = 0;
  // final screens = [
  //   HomePage(),
  //   CalenderPage(),
  //   //CreateNewTaskPage(),
  // ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const List<Widget> _pages = <Widget>[
      Icon(
        Icons.camera,
        size: 150,
      ),
      Icon(
        Icons.chat,
        size: 150,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            color: Colors.black,
            tooltip: 'Logout',
            onPressed: () {
              logOut();
            },
          ),
        ],
      ),
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 190,
              width: width,
              padding: EdgeInsets.all(0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.menu,
                            color: LightColors.kDarkBlue, size: 30.0),
                        Icon(Icons.search,
                            color: LightColors.kDarkBlue, size: 25.0),
                      ],
                    ),*/
                    Padding(
                      //padding: const EdgeInsets.symmetric(horizontal: 0),
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 70.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 0.75,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kRed,
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              // backgroundColor: LightColors.w,
                              backgroundColor:
                                  Color.fromARGB(117, 255, 255, 255),
                              radius: 50.0,
                              backgroundImage: AssetImage(
                                'assets/images/ex.png',
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  //'Asyikin Arif',
                                  "${email}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Student',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              // ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       primary: Colors.redAccent,
                              //       // side: BorderSide(color: Colors.yellow, width: 5),
                              //       textStyle: const TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 15,
                              //           fontStyle: FontStyle.normal,
                              //           fontWeight: FontWeight.bold),
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(10)),
                              //     ),
                              //     onPressed: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   TimetableStudent()));
                              //     },
                              //     child: Text('Get Started'))
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('My Actions'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TimetableWeek()),
                                  );
                                },
                                child: calendarIcon(),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TimetableStudent()));
                            },
                            child: TaskColumn(
                              icon: Icons.calendar_month,
                              iconBackgroundColor: LightColors.kRed,
                              title: 'Study Plan',
                              subtitle: 'Start generate your study plan here',
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TaskColumn(
                            icon: Icons.blur_circular,
                            iconBackgroundColor: LightColors.kDarkYellow,
                            title: 'To-do',
                            subtitle: 'Make your to-do list here',
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.check_circle_outline,
                            iconBackgroundColor: LightColors.kBlue,
                            title: 'TAK TAU NAK LETAK APA LAGI',
                            subtitle: '18 tasks now. 13 started',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          subheading('Progress Tasks'),
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kGreen,
                                loadingPercent: 0.25,
                                title: '            Todo List',
                                subtitle: '',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kRed,
                                loadingPercent: 0.6,
                                title: ' Completed Todo List',
                                subtitle: '',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: SalomonBottomBar(
      //   currentIndex: _selectedIndex,
      //   onTap: onItemTapped,
      //   //onTap: (i) => setState(() => _currentIndex = i),
      //   //onTap: onTappedBar,
      //   unselectedItemColor: Colors.deepPurple,
      //   // currentIndex: _selectedTab,
      //   // onTap: (position){
      //   //   setState(() {
      //   //     _selectedTab = position;
      //   //   });
      //   // },

      //   // currentIndex: _selectedIndex,
      //   // //selectedItemColor: Colors.amber[800],
      //   // onTap: onTabTapped,//_onItemTapped,

      //   items: [
      //     /// Home
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text("Home"),
      //       selectedColor: Colors.purple,
      //     ),

      //     /// Likes
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.add),
      //       title: Text("Add"),
      //       selectedColor: Colors.pink,
      //     ),

      //     /// Search
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.search),
      //       title: Text("Search"),
      //       selectedColor: Colors.orange,
      //     ),

      //     /// Profile
      //     SalomonBottomBarItem(
      //       icon: Icon(Icons.person),
      //       title: Text("Profile"),
      //       selectedColor: Colors.teal,
      //     ),
      //   ],
      //   //currentIndex: _selectedIndex,
      //   //onTap: _onItemTap,
      //   //selectedFontSize: 13.0,
      //   //unselectedFontSize: 13.0,
      // ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Text subheading(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kRed,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }
}
