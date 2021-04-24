import 'package:flutter/material.dart';

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
                  ],
                )
              ],
            ))))
      ],
    );
  }

  Widget welcomeText(context) {
    return Container(
        margin: EdgeInsets.only(top: 50, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Column(children: [
          Text(
            "Good morning, " + "Manolo",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28),
          )
        ]));
  }
}
