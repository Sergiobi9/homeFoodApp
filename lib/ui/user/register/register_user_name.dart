import 'package:flutter/material.dart';
import 'package:home_food_project/entities/user/user.dart';
import 'package:home_food_project/ui/user/register/register_user.dart';
import 'package:home_food_project/ui/user/register/register_user_email.dart';
import 'package:home_food_project/utils/utils.dart';

class RegisterUserNamePage extends StatelessWidget {

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
                child:Column(children: <Widget>[
          userNameQuestion(),
          userFistNameText(),
          userFirstNameInput(),
          userLastNameText(),
          userLastNameInput(),
          nextBtn(context)
        ])));
  }

  Widget userFistNameText(){
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Text(
          "First name",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget userLastNameText(){
    return Container(
        margin: EdgeInsets.only(top: 25, bottom: 5, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Text(
          "Last name",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget nextBtn(BuildContext context) {
    return Container(
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
              onPressed: () => { registerEmail(context) }),
        ));
  }

  void registerEmail(context){
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;

    if (firstName == ""){
      Utils.showToast("First name can not be empty");
      return;
    } else if (lastName == ""){
      Utils.showToast("Last name can not be empty");
      return;
    }

    RegisterUser.user.firstName = firstName;
    RegisterUser.user.lastName = lastName;

    Utils.navigateToNewScreen(context, RegisterUserEmailPage());
  }


  Widget userFirstNameInput() {
   return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: firstNameController,
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
            contentPadding: EdgeInsets.only(
              top: 25, bottom: 25, right: 25, left: 25, // HERE THE IMPORTANT PART
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            fillColor: Color(0xFFF8F8F8)),
      ),
    );
  }

  Widget userLastNameInput() {
   return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: lastNameController,
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
            contentPadding: EdgeInsets.only(
              top: 25, bottom: 25, right: 25, left: 25, // HERE THE IMPORTANT PART
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            fillColor: Color(0xFFF8F8F8)),
      ),
    );
  }

  Widget userNameQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "What is your name?",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
