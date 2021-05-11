import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/user/user_session.dart';
import 'package:home_food_project/ui/login/login.dart';
import 'package:home_food_project/ui/navigation/user_family_member_navigation.dart';
import 'package:home_food_project/ui/navigation/user_family_owner_navigation.dart';
import 'package:home_food_project/ui/navigation/user_navigation.dart';
import 'package:home_food_project/utils/shared_preferences.dart';

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
    Navigator.of(context)
        .pushAndRemoveUntil(screen, (Route<dynamic> route) => true);
  }

  void filterUser(context) async {
    String userRole = "";

    await SharedPref().getObjectFromStorage("userSession").then((value) => {
          if (value != null)
            userRole = UserSession.fromJsonMap(value).user.userRole
        });

    if (userRole == Constants.USER_ROLE) {
      navigatePage(context, UserNavigationPage());
    } else if (userRole == Constants.FAMILY_OWNER_ROLE) {
      navigatePage(context, UserFamilyOwnerNavigationPage());
    } else if (userRole == Constants.FAMILY_MEMBER_ROLE) {
      navigatePage(context, UserFamilyMemberNavigationPage());
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
