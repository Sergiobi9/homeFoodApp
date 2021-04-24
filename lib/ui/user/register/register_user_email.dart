import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/services/user/user_service.dart';
import 'package:home_food_project/ui/user/register/register_user.dart';
import 'package:home_food_project/ui/user/register/register_user_password.dart';
import 'package:home_food_project/utils/utils.dart';
import 'package:home_food_project/utils/validator.dart';

class RegisterUserEmailPage extends StatelessWidget {
  TextEditingController emailTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(children: <Widget>[
          userEmailQuestion(),
          userEmailText(),
          userEmailInput(),
          nextBtn(context)
        ])));
  }

  Widget userEmailText() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Text(
          "Email",
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
              onPressed: () => {registerPassword(context)}),
        ));
  }

  void registerPassword(context) {
    String email = emailTextController.text.toLowerCase();

    bool isEmailNotValid = Validator.checkEmailFormat(email);

    if (isEmailNotValid) {
      Utils.showToast("Email format is not valid");
      return;
    }

    UserService().checkUserAlreadyExists(email).then((value) => {
          if (value == Constants.USER_EXISTS)
            {
              Utils.showToast("There is already an account created with this email")
            }
          else if (value == Constants.RESPONSE_NOT_SUCCESS)
            {
              Utils.showToast("Something went wrong please try again later")
            }
          else
            {
              RegisterUser.user.email = email.toLowerCase(),
              Utils.navigateToNewScreen(context, RegisterUserPasswordPage())
            }
        });
  }

  Widget userEmailInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: emailTextController,
        keyboardType: TextInputType.emailAddress,
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
              top: 25, bottom: 25, right: 25,
              left: 25, // HERE THE IMPORTANT PART
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            fillColor: Color(0xFFF8F8F8)),
      ),
    );
  }

  Widget userEmailQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Which is your email?",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
