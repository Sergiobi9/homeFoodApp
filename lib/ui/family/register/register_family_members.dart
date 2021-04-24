import 'package:flutter/material.dart';
import 'package:home_food_project/utils/utils.dart';

class RegisterFamilyMemebersPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RegisterFamilyMemebersPage> {

  TextEditingController familyNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
                child:Column(children: <Widget>[
          familyMembersQuestion(),
        ])));
  }

  Widget familyMembersQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Add members to your family",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
