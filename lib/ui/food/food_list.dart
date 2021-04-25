import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/family/family_member_detailed.dart';
import 'package:home_food_project/entities/food/food_item.dart';
import 'package:home_food_project/entities/food/food_list.dart';
import 'package:home_food_project/services/family/family_member_service.dart';
import 'package:home_food_project/services/food/food_service.dart';
import 'package:home_food_project/ui/category/register/register_category_name.dart';
import 'package:home_food_project/ui/food/register/register_food_name.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';

class FoodListPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FoodListPage> {

  List<FoodList> foodList = [];
  String familyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: SingleChildScrollView(child: getFamilyInfo())));
  }

  Widget getFamilyInfo() {
    return FutureBuilder(
        future: FamilyMemberService().getFamilyMembers(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            familyId = snapshot.data['familyId'];
            String familyName = snapshot.data['familyName'];

            return Column(children: <Widget>[
              familyNameText(familyName),
              manageCategoriesAndSupermarketsButtons(familyId),
              categoriesAndFood(familyId),
            ]);
          } else {
            return Container();
          }
        });
  }

  manageCategoriesAndSupermarketsButtons(String familyId) {
    return Container(
      margin: EdgeInsets.only(top: 35, bottom: 35),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.43,
                margin: EdgeInsets.only(right: 10),
                child: SizedBox(
                    child: TextButton(
                        child: Text("Add category".toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF274060)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF274060)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        BorderSide(color: Color(0xFF274060))))),
                        onPressed: () => {addNewCategory(familyId)}))),
            Container(
                width: MediaQuery.of(context).size.width * 0.43,
                margin: EdgeInsets.only(left: 10),
                child: SizedBox(
                    child: TextButton(
                        child: Text("Add supermarket".toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFD72638)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFD72638)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        BorderSide(color: Color(0xFFD72638))))),
                        onPressed: () => {null})))
          ]),
    );
  }

  void addNewCategory(familyId) {
    Utils.navigateToNewScreen(
        context, RegisterCategoryNamePage(familyId: familyId));
  }

  Widget familyNameText(String familyName) {
    bool endsWithS = familyName.toLowerCase().endsWith("s");

    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        endsWithS ? familyName + "' food list" : familyName + "'s food list",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget categoriesAndFood(familyId) {
    return FutureBuilder(
        future: FoodService().getFoodListWithCategories(familyId),
        builder:
            (BuildContext context, AsyncSnapshot<List<FoodList>> snapshot) {
          print(snapshot.hasData.toString());
          if (snapshot.hasData) {
            foodList = snapshot.data;
            print(snapshot.data);
            return Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                          child: Container(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    categoryName(foodList[index].categoryName),
                                    categoryFoodListItems(
                                        foodList[index].foodItems,
                                        foodList[index].categoryId,
                                        foodList[index].categoryName)
                                  ]))));
                    }));
          } else {
            return Container();
          }
        });
  }

  Widget categoryName(categoryName) {
    return Container(
      margin: EdgeInsets.only(top: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        categoryName,
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  categoryFoodListItems(
      List<FoodItem> items, String categoryId, String categoryName) {
    if (items.length == 0) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.43,
          margin: EdgeInsets.only(top: 25, bottom: 25),
          child: SizedBox(
              child: TextButton(
                  child: Text("Add food".toUpperCase(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFE18335)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFE18335)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Color(0xFFE18335))))),
                  onPressed: () =>
                      {addFoodToCategory(categoryId, categoryName)})));
    } else {
      return Container(
          margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return new GestureDetector(
                      child: Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text(items[index].name),
                                if (index == items.length - 1)
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      margin:
                                          EdgeInsets.only(top: 25, bottom: 25),
                                      child: SizedBox(
                                          child: TextButton(
                                              child: Text("Add food".toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              style: ButtonStyle(
                                                  foregroundColor: MaterialStateProperty.all<Color>(
                                                      Color(0xFFE18335)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                          Color(0xFFE18335)),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0), side: BorderSide(color: Color(0xFF000000))))),
                                              onPressed: () => {addFoodToCategory(categoryId, categoryName)})))
                              ]))));
                }),
          ]));
    }
  }

  dynamic addFoodToCategory(categoryId, categoryName) {
    Utils.navigateToNewScreen(
        context, RegisterFoodNamePage(familyId: familyId, categoryId: categoryId, categoryName: categoryName));
  }

  removeUserFromFamily(index) {
    setState(() {
      foodList.removeAt(index);
    });
  }

  Widget familyMemberInfo(context, FamilyMemberDetailed item, index) {
    return Container(
        child: Row(
      children: [
        getUserInfo(item, context),
        if (index != 0) deleteUserIcon(index)
      ],
    ));
  }

  Widget deleteUserIcon(index) {
    return IconButton(
        icon: Icon(Icons.cancel_rounded, color: Colors.red),
        color: Colors.red,
        iconSize: 26,
        onPressed: () {
          removeUserFromFamily(index);
        });
  }

  Widget getUserInfo(FamilyMemberDetailed item, context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.33,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(5.0),
                child: Text(item.firstName + " " + item.lastName,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Container(
                margin: EdgeInsets.all(5.0),
                child: Text(getUserRole(item.userRole),
                    textAlign: TextAlign.start, style: TextStyle(fontSize: 16)))
          ]),
    );
  }

  String getUserRole(userRole) {
    switch (userRole) {
      case Constants.FAMILY_MEMBER_ROLE:
        return "Member";
      case Constants.FAMILY_OWNER_ROLE:
        return "Owner";
      default:
        return "User";
    }
  }

  Widget membersText() {
    return Container(
      margin: EdgeInsets.only(bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Members",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget familyMembersQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Add members to your family",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
