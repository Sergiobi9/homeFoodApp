import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/family/family_member_detailed.dart';
import 'package:home_food_project/services/family/family_member_service.dart';
import 'package:home_food_project/utils/shared_preferences.dart';

class FamilyDetailsPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FamilyDetailsPage> {
  TextEditingController familyMemberEmailController =
      new TextEditingController();
  List<FamilyMemberDetailed> familyMembers = [];

  String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          familyNameText(),
          manageFamilyButtons(),
          membersText(),
          membersAddedList(),
        ]))));
  }

  manageFamilyButtons() {
    return Container(
      margin: EdgeInsets.only(top: 35, bottom: 35),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(right: 15),
                child: SizedBox(
                    child: TextButton(
                        child: Text("Edit".toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(right: 50, left: 50)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFB497D6)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFB497D6)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        BorderSide(color: Color(0xFFB497D6))))),
                        onPressed: () => {null}))),
                        Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(right: 15),
                child: SizedBox(
                    child: TextButton(
                        child: Text("Delete".toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(right: 50, left: 50)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFB497D6)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFB497D6)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        BorderSide(color: Color(0xFFB497D6))))),
                        onPressed: () => {null})))
          ]),
    );
  }

  Widget familyNameText() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Obiols Olcina's family",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget membersAddedList() {
    return FutureBuilder(
        future: FamilyMemberService().getFamilyMembers(),
        builder: (BuildContext context,
            AsyncSnapshot<List<FamilyMemberDetailed>> snapshot) {
          if (snapshot.hasData) {
            familyMembers = snapshot.data;

            return Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                height: MediaQuery.of(context).size.height * 0.40,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: familyMembers.length,
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                          child: Container(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: familyMemberInfo(
                                      familyMembers[index], index))));
                    }));
          } else {
            return Container();
          }
        });
  }

  removeUserFromFamily(index) {
    setState(() {
      familyMembers.removeAt(index);
    });
  }

  Widget familyMemberInfo(FamilyMemberDetailed item, index) {
    return Container(
        child: Row(
      children: [getUserInfo(item), if (index != 0) deleteUserIcon(index)],
    ));
  }

  Widget deleteUserIcon(index) {
    return IconButton(
        icon: Icon(Icons.cancel_rounded, color: Colors.red),
        color: Colors.red,
        iconSize: 26,
        onPressed: () {
          removeUserFromFamily(index);
        });
  }

  Widget getUserInfo(FamilyMemberDetailed item) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.33,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(5.0),
                child: Text(item.firstName + " " + item.lastName,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Container(
                margin: EdgeInsets.all(5.0),
                child: Text(getUserRole(item.userRole),
                    textAlign: TextAlign.start, style: TextStyle(fontSize: 16)))
          ]),
    );
  }

  String getUserRole(userRole) {
    switch (userRole) {
      case Constants.FAMILY_MEMBER_ROLE:
        return "Member";
      case Constants.FAMILY_OWNER_ROLE:
        return "Owner";
      default:
        return "User";
    }
  }

  Widget membersText() {
    return Container(
      margin: EdgeInsets.only(bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Members",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    );
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
