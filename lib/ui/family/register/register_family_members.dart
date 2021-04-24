import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/family/family_member_user_request.dart';
import 'package:home_food_project/entities/family/family_register.dart';
import 'package:home_food_project/entities/user/user_session.dart';
import 'package:home_food_project/services/family/family_service.dart';
import 'package:home_food_project/services/user/user_service.dart';
import 'package:home_food_project/ui/family/register/register_family.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';

class RegisterFamilyMemebersPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RegisterFamilyMemebersPage> {
  TextEditingController familyMemberEmailController =
      new TextEditingController();

  List<FamilyMemberUserRequest> familyMembers = [];

  String userEmail;

  @override
  Widget build(BuildContext context) {
    getUserEmail();

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          familyMembersQuestion(),
          familyMembersInput(),
          membersText(),
          membersAddedList(),
          nextBtn()
        ]))));
  }

  dynamic getUserEmail() async{
    await SharedPref().getStringFromStorage("userEmail").then((value) => userEmail = value);
  }

  Widget membersAddedList() {
    if (familyMembers.length <= 0) {
      return Container(
          margin: EdgeInsets.only(top: 25.0, right: 20, left: 20, bottom: 50),
          child: Text("No family members added"));
    } else {
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
    }
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

  removeUserFromFamily(index) {
    setState(() {
      familyMembers.removeAt(index);
    });
  }

  Widget familyMemberInfo(FamilyMemberUserRequest item, index) {
    return Container(
        child: Row(
      children: [getUserInfo(item), deleteUserIcon(index)],
    ));
  }

  Widget getUserInfo(FamilyMemberUserRequest item) {
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
                child: Text(item.email,
                    textAlign: TextAlign.start, style: TextStyle(fontSize: 16)))
          ]),
    );
  }

  Widget nextBtn() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: const EdgeInsets.only(
                top: 25.0, bottom: 10.0, left: 25.0, right: 25.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  child: Text("Next".toUpperCase(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(25)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () => {registerFamily()}),
            )));
  }

  dynamic registerFamily(){
    List<String> membersUserIds = [];

    for (FamilyMemberUserRequest familyMemberUserRequest in familyMembers){
      String userId = familyMemberUserRequest.userId;
      membersUserIds.add(userId);
    }

    RegisterFamily.familyRegister.membersUserIds = membersUserIds;
    FamilyRegister familyRegister = RegisterFamily.familyRegister;
    FamilyService().registerFamily(familyRegister).then((value) => {
      if (value == Constants.SUCCESS){
        Utils.showToast("Family created successfully"),
        updateUserRole()
      } else {
        Utils.showToast("Something went wrong please try again later"),
      }
    });
  }

  void updateUserRole() async {
    String familyOwnerRole = Constants.FAMILY_OWNER_ROLE;

    dynamic userSession = await SharedPref().getObjectFromStorage("userSession");
    userSession['user']['userRole'] = familyOwnerRole;
    await SharedPref().saveObjectToStorage("userSession", userSession);

    redirectUser(familyOwnerRole);
  }

  void redirectUser(userRole){
    Utils().filterUser(context, userRole);
  }

  Widget familyMembersInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: familyMemberEmailController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: 18, // This is not so important
        ),
        decoration: new InputDecoration(
            errorBorder: InputBorder.none,
            focusColor: Color(0xFFF8F8F8),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(15.0),
              ),
            ),
            suffixIcon: new GestureDetector(
              onTap: () {
                addMembers();
              },
              child: new Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    Icons.check_rounded,
                    color: Color(0xff333333),
                  ),
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 25, bottom: 25, right: 25,
              left: 25, // HERE THE IMPORTANT PART
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            hintText: "Write email or uid",
            fillColor: Color(0xFFF8F8F8)),
      ),
    );
  }

  dynamic addMembers() {
    String identifier = familyMemberEmailController.text;
  
    if (userEmail == identifier){
      Utils.showToast("You are the family owner");
      return;
    }

    UserService().checkUserExistToBeFamilyMember(identifier).then((value) => {
          if (value == Constants.USER_DO_NOT_EXIST){
            Utils.showToast("User do not exist")
          }
          else if (value == Constants.RESPONSE_NOT_SUCCESS){
            Utils.showToast("Something went wrong, please try again later.")
          }
          else { 
              familyMemberEmailController.text = "",
              setState(() {
                Utils.showToast("Added new member");
                familyMembers.add(value);
              })
            }
        });
  }

  Widget membersText() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
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
