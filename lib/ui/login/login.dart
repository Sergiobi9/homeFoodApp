import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/ui/navigation/user_navigation.dart';
import 'package:home_food_project/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<LoginPage> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool obscureTextPassword = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 4.0, right: 4.0),
            height: 44.0 + MediaQuery.of(context).padding.bottom,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          body: SafeArea(
              child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                loginText(),
                accessAccount(),
                socialMediaButtons(context),
                loginViaEmailText(),
                emailText(),
                emailInput(),
                passwordText(),
                passwordInput(),
                loginBtn(),
                dontHaveAccount(),
              ]))))
    ]);
  }

  Widget dontHaveAccount(){
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 5, right: 25, left: 25),
        child: Text(
          "Do not have account? Register",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ));
  }

  Widget loginBtn(){
    return Container(
        margin: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
              child: Text("Sign in".toUpperCase(),
                  style: TextStyle(
                      fontSize: 16,
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
              onPressed: () => { login() }),
        ));
  }

  dynamic login(){
    Utils.navigatePage(context, UserNavigationPage());
  }

  Widget loginViaEmailText() {
    return Container(
        margin: EdgeInsets.only(top: 25, bottom: 5, right: 25, left: 25),
        child: Text(
          "Or login via email",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ));
  }

  Widget passwordText(){
    return Container(
        margin: EdgeInsets.only(top: 25, bottom: 5, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Text(
          "Password",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget emailText(){
    return Container(
        margin: EdgeInsets.only(top: 25, bottom: 5, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Text(
          "Email",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget emailInput(){
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.text,
        obscureText: obscureTextPassword,
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

  Widget passwordInput() {
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
                    // Based on passwordVisible state choose the icon
                    obscureTextPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded,
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
              top: 25, bottom: 25, right: 25, left: 25, // HERE THE IMPORTANT PART
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


  Widget loginText() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, right: 25, left: 25),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ));
  }

  Widget accessAccount() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 20, right: 25, left: 25),
        child: Text(
          "Access account",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget socialMediaButtons(context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(right: 15),
              child: TextButton(
                  child: Image.asset(
                    Constants.GOOGLE_ICON,
                    height: 65,
                    width: 65,
                    fit: BoxFit.scaleDown,
                  ),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF8F8F8)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF8F8F8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Color(0xFFF8F8F8))))),
                  onPressed: () => {null}),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(left: 15),
              child: TextButton(
                  child: Image.asset(
                    Constants.FACEBOOK_ICON,
                    height: 65,
                    width: 65,
                    fit: BoxFit.scaleDown,
                  ),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF8F8F8)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF8F8F8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Color(0xFFF8F8F8))))),
                  onPressed: () => {null}),
            )
          ]),
    );
  }
}
