import 'package:flutter/material.dart';
import 'package:home_food_project/ui/family/family_details.dart';
import 'package:home_food_project/ui/item/item_list.dart';
import 'package:home_food_project/utils/utils.dart';

class UserFamilyOwnerHomePage extends StatelessWidget {
  List recentActivity = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                child: SafeArea(
                    child: SingleChildScrollView(
                        child: Stack(
              children: [
                Column(
                  children: [
                    welcomeText(context),
                    manageBtnCarousel(context),
                    recentActivityText(),
                    recentActivityList(context),
                  ],
                )
              ],
            )))))
      ],
    );
  }

  manageBtnCarousel(context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20, top: 15),
        height: MediaQuery.of(context).size.height * 0.1,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              if (index == 0) {
                return manageFamilyBtn(context);
              } else if (index == 1) {
                return manageFoodBtn(context);
              } else if (index == 2) {
                return categoriesBtn(context);
              } else if (index == 3) {
                return locationsBtn(context);
              } else {
                return newsBtn(context);
              }
            }));
  }

  Widget categoriesBtn(context){
    return Container(
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text("Categories",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(right: 50, left: 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF274060)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF274060)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFF274060))))),
              onPressed: () => {}),
        ));
  }

  Widget locationsBtn(context) {
    return Container(
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text("Locations",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(right: 50, left: 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFC16E70)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFC16E70)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFFC16E70))))),
              onPressed: () => {}),
        ));
  }

  Widget recentActivityList(context) {
    return Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: recentActivity.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                  child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container())));
            }));
  }

  Widget manageFoodBtn(context) {
    return Container(
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text("Items list",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(right: 50, left: 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFE18335)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFE18335)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFFE18335))))),
              onPressed: () => {itemsList(context)}),
        ));
  }

  Widget newsBtn(context) {
    return Container(
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text("News",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(right: 50, left: 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF8EA8C3)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF8EA8C3)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFF8EA8C3))))),
              onPressed: () => {}),
        ));
  }

  Widget manageFamilyBtn(context) {
    return Container(
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, left: 25.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text("Family",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(right: 50, left: 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFB497D6)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFB497D6)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFFB497D6))))),
              onPressed: () => {familyDetails(context)}),
        ));
  }

  void familyDetails(context){
    Utils.navigateToNewScreen(context, FamilyDetailsPage());
  }

   void itemsList(context){
    Utils.navigateToNewScreen(context, ItemListPage());
  }

  Widget recentActivityText() {
    return Container(
        margin: EdgeInsets.only(top: 25, bottom: 25, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Column(children: [
          Text(
            "Recent activity",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          )
        ]));
  }

  Widget welcomeText(context) {
    return Container(
        margin: EdgeInsets.only(top: 50, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Column(children: [
          Text(
            "Good morning, " + "Pepe",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          )
        ]));
  }
}
