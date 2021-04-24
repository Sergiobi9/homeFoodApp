import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/ui/login/login.dart';
import 'package:home_food_project/ui/navigation/user_navigation.dart';

class Utils {
  
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  static void navigateToNewScreen(context, screen) {
    final route = MaterialPageRoute(builder: (context) {
      return screen;
    });
    Navigator.push(context, route);
  }

  static void navigateToNewScreenAndClear(context, screen) {
      Navigator.of(context).pushAndRemoveUntil(
                    screen, (Route<dynamic> route) => true);
  }

  void filterUser(context, String role) {
    if (role == Constants.USER_ROLE) {
      navigatePage(context, UserNavigationPage());
    } else if (role == Constants.FAMILY_OWNER_ROLE){
      navigatePage(context, LoginPage());
    } else if (role == Constants.FAMILY_MEMBER_ROLE){
      navigatePage(context, LoginPage());
    }
  }

  static void navigatePage(context, page) {
    final route = MaterialPageRoute(builder: (context) {
      return page;
    });
    Navigator.pushReplacement(context, route);
  }

  static String capitalize(word) {
    return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
  }
}
