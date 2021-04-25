import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/item/item.dart';
import 'package:home_food_project/entities/item_location/item_location_register_simplified.dart';
import 'package:home_food_project/entities/item_location/item_location_simplified.dart';
import 'package:home_food_project/services/item/item_service.dart';
import 'package:home_food_project/services/item_location/item_location_service.dart';
import 'package:home_food_project/ui/item/item_list.dart';
import 'package:home_food_project/ui/item/register/register_item.dart';
import 'package:home_food_project/utils/utils.dart';

class RegisterItemLocationsAvailablePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RegisterItemLocationsAvailablePage> {
  TextEditingController itemLocationController = new TextEditingController();

  String userEmail;
  String familyId;

  List<ItemLocationSimplified> itemLocationsAvailable = [];
  List<ItemLocationSimplified> itemLocationsAdded = [];

  @override
  Widget build(BuildContext context) {
    familyId = RegisterItem.item.familyId;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          locationsQuestion(),
          locationsList(),
          locationsInput(),
          locationsText(),
          locationsAddedList(),
          nextBtn()
        ]))));
  }

  Widget locationsList() {
    return FutureBuilder(
        future: ItemLocationService().getFamilyItemLocations(familyId),
        builder: (BuildContext context,
            AsyncSnapshot<List<ItemLocationSimplified>> snapshot) {
          if (snapshot.hasData) {
            itemLocationsAvailable = snapshot.data;

            return Container(
                margin: EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemLocationsAvailable.length,
                    itemBuilder: (context, index) {
                      return itemLocation(
                          context, itemLocationsAvailable[index], index);
                    }));
          } else {
            return Container();
          }
        });
  }

  Widget itemLocation(context, ItemLocationSimplified itemLocation, index) {
    return Container(
        margin: index == 0
            ? const EdgeInsets.only(
                top: 15.0, bottom: 15.0, left: 25.0, right: 5.0)
            : const EdgeInsets.only(
                top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text(itemLocation.itemLocationName,
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
              onPressed: () => {addOrRemoveLocation(itemLocation)}),
        ));
  }

  addOrRemoveLocation(ItemLocationSimplified itemLocation) {
    int position = -1;

    for (var i = 0; i < itemLocationsAdded.length && position == -1; i++) {
      if (itemLocation.itemLocationId == itemLocationsAdded[i].itemLocationId) {
        position = i;
      }
    }

    setState(() {
      position != -1
          ? itemLocationsAdded.removeAt(position)
          : itemLocationsAdded.add(itemLocation);
    });
  }

  Widget locationsAddedList() {
    if (itemLocationsAdded.length <= 0) {
      return Container(
          margin: EdgeInsets.only(top: 25.0, right: 20, left: 20, bottom: 50),
          child: Text("No places added"));
    } else {
      return Container(
          margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: itemLocationsAdded.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                    child: Container(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: itemLocationInfo(
                                itemLocationsAdded[index], index))));
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
      itemLocationsAdded.removeAt(index);
    });
  }

  Widget itemLocationInfo(ItemLocationSimplified item, index) {
    return Container(
        child: Row(
      children: [getFullLocationInfo(item), deleteFoodLocationIcon(index)],
    ));
  }

  Widget getFullLocationInfo(ItemLocationSimplified item) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.33,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(5.0),
                child: Text(item.itemLocationName,
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
    Item item = RegisterItem.item;

    List<String> itemLocationIds = [];
    for (ItemLocationSimplified itemLocationSimplified in itemLocationsAdded) {
      String itemLocationId = itemLocationSimplified.itemLocationId;
      itemLocationIds.add(itemLocationId);
    }

    item.availableItemLocationIds = itemLocationIds;

    String categoryId = RegisterItem.categoryId;

    ItemService().registerItemToCategory(item, categoryId).then((value) => {
          if (value == Constants.SUCCESS)
            {redirectFoodList(context)}
          else
            {Utils.showToast("Something went wrong, try again later")}
        });
  }

  void redirectFoodList(context) {
    Utils.showToast("Food added");
    Utils.navigatePage(context, ItemListPage());
  }

  Widget locationsInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: itemLocationController,
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
            hintText: "Add new location name",
            fillColor: Color(0xFFF8F8F8)),
      ),
    );
  }

  dynamic addFoodNewFoodLocation() {
    String itemLocationName = itemLocationController.text;

    ItemLocationRegisterSimplified itemLocationRegisterSimplified =
        ItemLocationRegisterSimplified();
    itemLocationRegisterSimplified.name = itemLocationName;
    itemLocationRegisterSimplified.familyId = RegisterItem.item.familyId;

    ItemLocationService()
        .registerItemLocationName(itemLocationRegisterSimplified)
        .then((value) => {
              if (value == Constants.ITEM_LOCATION_EXISTS)
                {Utils.showToast("This location already exists")}
              else if (value == Constants.RESPONSE_NOT_SUCCESS)
                {Utils.showToast("Something went wrong, try again later")}
              else
                {
                  itemLocationController.text = "",
                  setState(() {
                    Utils.showToast("Added new location");
                    itemLocationsAdded.add(value);
                  })
                }
            });
  }

  Widget locationsText() {
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

  Widget locationsQuestion() {
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
