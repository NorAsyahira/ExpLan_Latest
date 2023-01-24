import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:time2study/screens/calender/timetable_week.dart';
import 'package:time2study/screens/formData/activity_time.dart';
import 'package:time2study/screens/formData/timetable.dart';
import 'package:time2study/screens/signup/home_page.dart';

import '../../theme/colors/light_colors.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  final widgetOptions = [
    HomePage(),
    TimetableStudent(),
    ActivityTime(),
    TimetableWeek(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        //onTap: (i) => setState(() => _currentIndex = i),
        //onTap: onTappedBar,
        unselectedItemColor: Colors.black54,
        // currentIndex: _selectedTab,
        // onTap: (position){
        //   setState(() {
        //     _selectedTab = position;
        //   });
        // },

        // currentIndex: _selectedIndex,
        // //selectedItemColor: Colors.amber[800],
        // onTap: onTabTapped,//_onItemTapped,

        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.book),
            title: Text("Form"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.list_alt_rounded),
            title: Text("List"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            title: Text("Study Plan"),
            selectedColor: Colors.teal,
          ),
        ],
        //currentIndex: _selectedIndex,
        //onTap: _onItemTap,
        //selectedFontSize: 13.0,
        //unselectedFontSize: 13.0,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
