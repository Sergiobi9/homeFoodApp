import 'package:flutter/material.dart';
import 'package:home_food_project/ui/login/login.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';

class UserProfilePage extends StatefulWidget {
  @override
  UserProfilePageImplementation createState() =>
      UserProfilePageImplementation();
}

class UserProfilePageImplementation extends State<UserProfilePage> {
  bool profilePicture = true;

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: Center(
              child: getUserInfo(bodyHeight),
            )))
      ],
    );
  }

  Widget getUserInfo(bodyHeight) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //getProfilePicture(bodyHeight),
            logoutBtn(),
          ],
        ));
  }

  Widget logoutBtn() {
    return Container(
        margin: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextButton(
              child: Text("Sign out".toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(color: Colors.black)))),
              onPressed: () => {doLogout()}),
        ));
  }

  void doLogout() async {
    await SharedPref().saveBooleanToStorage("isUserLoggedIn", false);
    await SharedPref().saveStringToStorage("userEmail", "");
    await SharedPref().saveStringToStorage("userId", "");
    await SharedPref().saveObjectToStorage("userSession", null);
    Utils.navigatePage(context, LoginPage());
  }

  Widget getProfilePicture(bodyHeight) {
    if (profilePicture) {
      return Container(
          width: bodyHeight * 0.6,
          height: bodyHeight * 0.6,
          margin: const EdgeInsets.only(top: 75.0, bottom: 10.0),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(
                      "https://ep01.epimg.net/elpais/imagenes/2019/06/24/icon/1561369019_449523_1561456608_noticia_normal.jpg"))));
    } else {
      return Container(
        width: bodyHeight * 0.6,
        height: bodyHeight * 0.6,
        child: Center(
          child: Icon(
            Icons.account_circle,
            size: bodyHeight * 0.2,
            color: Color(0xffC0C0C0),
          ),
        ),
        margin: const EdgeInsets.only(top: 75.0, bottom: 10.0),
        decoration: new BoxDecoration(
          color: Color(0xffF1F1F1),
          shape: BoxShape.circle,
        ),
      );
    }
  }
}
