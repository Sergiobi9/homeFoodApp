import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_food_project/ui/item/register/register_item.dart';
import 'package:home_food_project/ui/item/register/register_item_locations_available.dart';
import 'package:home_food_project/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class RegisterItemImage extends StatefulWidget {
  @override
  RegisterItemImageImplementation createState() =>
      RegisterItemImageImplementation();
}

class RegisterItemImageImplementation extends State<RegisterItemImage> {
  
  File imageFile;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Stack(children: [
          imageSource(context),
          itemImageQuestion(),
          nextBtn(context)
        ])));
  }

  Widget nextBtn(BuildContext context) {
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
                        MaterialStateProperty.all<Color>(Color(0xFFE18335)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFE18335)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Color(0xFFE18335))))),
                onPressed: () => {nextStep(context)}),
          )),
    );
  }

  void nextStep(context) {
    RegisterItem.imageFile = imageFile;
    Utils.navigateToNewScreen(context, RegisterItemLocationsAvailablePage());
  }

  Widget imageSource(context) {
    return new GestureDetector(
        onTap: () {
          getCameraImage(context);
        },
        child: imageFile == null
            ? Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: Icon(
                      Icons.account_circle,
                      size: MediaQuery.of(context).size.width * 0.2,
                      color: Color(0xffC0C0C0),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    color: Color(0xffF1F1F1),
                    shape: BoxShape.circle,
                  ),
                ))
            : Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: new FileImage(imageFile),
                        radius: 175,
                        backgroundColor: Colors.white,
                      ),
                      Container(
                          child: new GestureDetector(
                        onTap: () {
                          getCameraImage(context);
                        },
                        child: Text("Choose a new photo"),
                      ))
                    ],
                  ),
                )));
  }

  getCameraImage(context) async {
    setState(() {
      imageFile = null;
    });

    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      cropImage(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }

  Widget itemImageQuestion() {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin:
              EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
          alignment: Alignment.topLeft,
          child: Text(
            "Add a photo",
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  Future<Null> cropImage(image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'HomeFood cropper',
            toolbarColor: Color(0xFFE18335),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      setState(() {
        imageFile = croppedFile;
      });
    }
  }
}
