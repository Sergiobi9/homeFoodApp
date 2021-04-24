import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/ui/home/user_home_page.dart';
import 'package:home_food_project/ui/user/profile/user_profile.dart';

class UserNavigationPage extends StatefulWidget {
  UserNavigationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  NavigationPageState createState() => NavigationPageState();
}

class NavigationPageState extends State<UserNavigationPage> {

  int _currentIndex = 0;
  String userRole = Constants.USER_ROLE;

  final tabs = [
    UserHomePage(),
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text('Home'),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('My Profile'),
              backgroundColor: Colors.black),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
