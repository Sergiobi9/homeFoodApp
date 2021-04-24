import 'package:flutter/material.dart';

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
                child: SingleChildScrollView(
              child: getUserInfo(bodyHeight),
            )))
      ],
    );
  }

  Widget getUserInfo(bodyHeight) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[getProfilePicture(bodyHeight)],
        ));
  }

  Widget getProfilePicture(bodyHeight) {
    if (profilePicture) {
      return Container(
          width: bodyHeight * 0.6,
          height: bodyHeight * 0.6,
          margin: const EdgeInsets.only(top: 50.0, bottom: 10.0),
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
        margin: const EdgeInsets.only(top: 50.0, bottom: 10.0),
        decoration: new BoxDecoration(
          color: Color(0xffF1F1F1),
          shape: BoxShape.circle,
        ),
      );
    }
  }
}
