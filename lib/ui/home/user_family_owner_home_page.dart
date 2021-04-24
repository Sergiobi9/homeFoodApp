import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/ui/family/register/register_family_name.dart';
import 'package:home_food_project/utils/utils.dart';

class UserFamilyOwnerHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                child: SafeArea(
                    child: Stack(
              children: [
                Column(
                  children: [
                     welcomeText(context),
                    recentActivityText(),
                  ],
                )
               
              ],
            ))))
      ],
    );
  }

  Widget recentActivityText(){
    return Container(
        margin: EdgeInsets.only(top: 25, bottom: 25, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Column(children: [
          Text(
            "Recent activity",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget welcomeText(context) {
    return Container(
        margin: EdgeInsets.only(top: 50, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Column(children: [
          Text(
            "Good morning, " + "Manolo" ,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28),
          )
        ]));
  }

}

