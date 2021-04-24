import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(left: 4.0, right: 4.0),
              height: 44.0 + MediaQuery.of(context).padding.bottom,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            body: Stack(
                children: <Widget>[Text("User Profile")]))
      ],
    );
  }
}
