import 'package:flutter/material.dart';
import 'package:home_food_project/entities/user/user.dart';
import 'package:home_food_project/entities/user/user_session.dart';
import 'package:home_food_project/services/user/user_service.dart';
import 'package:home_food_project/ui/navigation/user_navigation.dart';
import 'package:home_food_project/ui/user/register/register_user.dart';
import 'package:home_food_project/utils/date_utils.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';
import 'package:home_food_project/utils/validator.dart';

class RegisterUserPasswordPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RegisterUserPasswordPage> {
  TextEditingController passwordController = new TextEditingController();
  bool obscureTextPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(children: <Widget>[
          userPasswordQuestion(),
          userPasswordText(),
          userPasswordInput(),
          nextBtn(context)
        ])));
  }

  Widget userPasswordText() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Text(
          "Password",
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
              onPressed: () => {registerAccount()}),
        ));
  }

  void registerAccount() {
    String password = passwordController.text;

    bool isPasswordNotValid = Validator.checkPasswordFormat(password);

    if (isPasswordNotValid) {
      Utils.showToast("Password must be eight caracters long");
      return;
    }

    User user = RegisterUser.user;
    user.password = password;
    user.dateRegistered = DateUtilsHelper.timeStamp();

    UserService().registerUser(user).then((UserSession userSession) async {
      if (userSession == null) {
        Utils.showToast(
            "Something went wrong creating your account, please try again later");
      } else {
        loginUser(userSession);
      }
    });
  }

  dynamic loginUser(UserSession userSession) async {
    String userRole = userSession.user.userRole;

    await SharedPref().saveBooleanToStorage("isUserLoggedIn", true);
    await SharedPref().saveStringToStorage("userEmail", userSession.user.email);
    await SharedPref().saveStringToStorage("userId", userSession.user.id);
    await SharedPref().saveObjectToStorage("userSession", userSession);
    Utils().filterUser(context, userRole);
  }

  Widget userPasswordInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 25.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        obscureText: obscureTextPassword,
        style: TextStyle(
          fontSize: 18, // This is not so important
        ),
        decoration: new InputDecoration(
            errorBorder: InputBorder.none,
            focusColor: Color(0xFFF8F8F8),
            suffixIcon: new GestureDetector(
              onTap: () {
                togglePasswordIcon();
              },
              child: new Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    obscureTextPassword
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Color(0xff333333),
                  ),
                ),
              ),
            ),
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

  void togglePasswordIcon() {
    setState(() {
      obscureTextPassword = !obscureTextPassword;
    });
  }

  Widget userPasswordQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Create a password",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
