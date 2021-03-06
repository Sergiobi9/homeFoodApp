import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/ui/family/register/register_family_name.dart';
import 'package:home_food_project/utils/utils.dart';

class UserHomePage extends StatelessWidget {
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
                welcomeText(context),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[addFirstFamily(), addFamilyBtn(context)])
              ],
            ))))
      ],
    );
  }

  Widget welcomeText(context) {
    return Container(
        margin: EdgeInsets.only(top: 50, bottom: 25, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Column(children: [
          Text(
            "Good morning, " + "Sergi" ,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          )
        ]));
  }

  Widget addFirstFamily() {
    return Container(
        margin: EdgeInsets.only(top: 65, bottom: 50, right: 50, left: 50),
        child: Text(
          "To start, you have to be part of a family or create one",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget addFamilyBtn(context) {
    return Container(
        margin: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
              child: Text("Create family".toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(25)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.black)))),
              onPressed: () => { createFamily(context)}),
        ));
  }

  Widget createFamily(context){
    Utils.navigateToNewScreen(context, RegisterFamilyNamePage());
  }
}

