import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_food_project/ui/login/login.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';

import 'entities/user_session.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  bool userHasLoggedIn = false;
  UserSession userSession;

  @override
  Widget build(BuildContext context) {
    
    getUiDependingOnUser(context).then((res) {
      if (res == true && userSession != null) {
        Utils.filterUser(context, userSession.user.userRole);
      } else {
        Utils.navigatePage(context, LoginPage());
      }
    });

    return Scaffold(
        body: new Card(
      child: new Center(),
    ));
  }

  Future<bool> getUiDependingOnUser(BuildContext context) async {
    bool userHasLoggedIn = false;
    await SharedPref()
        .getBooleanFromStorage("isUserLoggedIn")
        .then((value) => userHasLoggedIn = value);

    await SharedPref()
        .getObjectFromStorage("userSession")
        .then((value) => {
          if(value != null) userSession = UserSession.fromJsonMap(value)
        });

    return userHasLoggedIn;
  }
}
