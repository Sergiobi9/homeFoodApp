import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/family/family_member_register.dart';
import 'package:home_food_project/entities/family/family_member_user_request.dart';
import 'package:home_food_project/entities/family/family_register.dart';
import 'package:home_food_project/entities/food/food.dart';
import 'package:home_food_project/entities/food_location/food_location.dart';
import 'package:home_food_project/entities/food_location/food_location_register_simplified.dart';
import 'package:home_food_project/entities/food_location/food_location_simplified.dart';
import 'package:home_food_project/services/family/family_service.dart';
import 'package:home_food_project/services/food/food_service.dart';
import 'package:home_food_project/services/food_location/food_location_service.dart';
import 'package:home_food_project/services/user/user_service.dart';
import 'package:home_food_project/ui/family/register/register_family.dart';
import 'package:home_food_project/ui/food/register/register_food.dart';
import 'package:home_food_project/utils/date_utils.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';

import '../food_list.dart';

class RegisterFoodSupermarketsAvailablePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RegisterFoodSupermarketsAvailablePage> {
  TextEditingController foodLocationController = new TextEditingController();

  String userEmail;
  String familyId;

  List<FoodLocationSimplified> foodLocationsAvailable = [];
  List<FoodLocationSimplified> foodLocationsAdded = [];

  @override
  Widget build(BuildContext context) {
    familyId = RegistrerFood.food.familyId;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          superMarketQuestion(),
          placesList(),
          placesInput(),
          placesText(),
          placesAddedList(),
          nextBtn()
        ]))));
  }

  Widget placesList() {
    return FutureBuilder(
        future: FoodLocationService().getFamilyFoodLocations(familyId),
        builder: (BuildContext context,
            AsyncSnapshot<List<FoodLocationSimplified>> snapshot) {
          if (snapshot.hasData) {
            foodLocationsAvailable = snapshot.data;

            return Container(
                margin: EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodLocationsAvailable.length,
                    itemBuilder: (context, index) {
                      return foodLocationBtn(
                          context, foodLocationsAvailable[index], index);
                    }));
          } else {
            return Container();
          }
        });
  }

  Widget foodLocationBtn(context, FoodLocationSimplified foodLocation, index) {
    return Container(
        margin: index == 0
            ? const EdgeInsets.only(
                top: 15.0, bottom: 15.0, left: 25.0, right: 5.0)
            : const EdgeInsets.only(
                top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text(foodLocation.foodLocationName,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
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
              onPressed: () => {addOrRemoveLocation(foodLocation)}),
        ));
  }

  addOrRemoveLocation(FoodLocationSimplified foodLocation) {
    int position = -1;

    for (var i = 0; i < foodLocationsAdded.length && position == -1; i++) {
      if (foodLocation.foodLocationId == foodLocationsAdded[i].foodLocationId) {
        position = i;
      }
    }

    setState(() {
      position != -1
          ? foodLocationsAdded.removeAt(position)
          : foodLocationsAdded.add(foodLocation);
    });
  }

  Widget placesAddedList() {
    if (foodLocationsAdded.length <= 0) {
      return Container(
          margin: EdgeInsets.only(top: 25.0, right: 20, left: 20, bottom: 50),
          child: Text("No places added"));
    } else {
      return Container(
          margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
          height: MediaQuery.of(context).size.height * 0.40,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: foodLocationsAdded.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                    child: Container(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: foodLocationInfo(
                                foodLocationsAdded[index], index))));
              }));
    }
  }

  Widget deleteFoodLocationIcon(index) {
    return IconButton(
        icon: Icon(Icons.cancel_rounded, color: Colors.red),
        color: Colors.red,
        iconSize: 26,
        onPressed: () {
          removeFoodLocationFromList(index);
        });
  }

  removeFoodLocationFromList(index) {
    setState(() {
      foodLocationsAdded.removeAt(index);
    });
  }

  Widget foodLocationInfo(FoodLocationSimplified item, index) {
    return Container(
        child: Row(
      children: [getFullLocationInfo(item), deleteFoodLocationIcon(index)],
    ));
  }

  Widget getFullLocationInfo(FoodLocationSimplified item) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.33,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(5.0),
                child: Text(item.foodLocationName,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ]),
    );
  }

  Widget nextBtn() {
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
                  onPressed: () => {registerFood()}),
            )));
  }

  void registerFood() {
    Food food = RegistrerFood.food;

    List<String> foodLocationIds = [];
    for (FoodLocationSimplified foodLocationSimplified in foodLocationsAdded){
      String foodLocationId = foodLocationSimplified.foodLocationId;
      foodLocationIds.add(foodLocationId);
    } 

    food.availableFoodLocationIds = foodLocationIds;

    FoodService().registerFood(food).then((value) => {
          if (value == Constants.SUCCESS)
            {redirectFoodList(context)}
          else
            {Utils.showToast("Something went wrong, try again later")}
        });
  }

  void redirectFoodList(context) {
    Utils.showToast("Category added");
    Utils.navigatePage(context, FoodListPage());
  }

  Widget placesInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: foodLocationController,
        keyboardType: TextInputType.text,
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
            suffixIcon: new GestureDetector(
              onTap: () {
                addFoodNewFoodLocation();
              },
              child: new Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    Icons.check_rounded,
                    color: Color(0xff333333),
                  ),
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 25, bottom: 25, right: 25,
              left: 25, // HERE THE IMPORTANT PART
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            hintText: "Add new supermarket name",
            fillColor: Color(0xFFF8F8F8)),
      ),
    );
  }

  dynamic addFoodNewFoodLocation() {
    String foodLocationName = foodLocationController.text;

    FoodLocationRegisterSimplified foodLocationRegisterSimplified =
        FoodLocationRegisterSimplified();
    foodLocationRegisterSimplified.name = foodLocationName;
    foodLocationRegisterSimplified.familyId = RegistrerFood.food.familyId;

    FoodLocationService()
        .registerFoodLocationName(foodLocationRegisterSimplified)
        .then((value) => {
              if (value == Constants.FOOD_LOCATION_EXISTS)
                {Utils.showToast("This location already exists")}
              else if (value == Constants.RESPONSE_NOT_SUCCESS)
                {Utils.showToast("Something went wrong, try again later")}
              else
                {
                  foodLocationController.text = "",
                  setState(() {
                    Utils.showToast("Added new location");
                    foodLocationsAdded.add(value);
                  })
                }
            });
  }

  Widget placesText() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Places",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget superMarketQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Where can it be found?",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
