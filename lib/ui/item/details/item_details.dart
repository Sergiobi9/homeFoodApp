import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/category/category_details.dart';
import 'package:home_food_project/entities/item/item_details.dart';
import 'package:home_food_project/entities/item_location/item_location_details.dart';
import 'package:home_food_project/services/item/item_service.dart';
import 'package:home_food_project/utils/utils.dart';

class ItemDetailsPage extends StatefulWidget {
  ItemDetailsPage({Key key, this.itemId}) : super(key: key);
  String itemId;

  @override
  ItemDetailsPageImplementation createState() =>
      ItemDetailsPageImplementation(itemId: this.itemId);
}

class ItemDetailsPageImplementation extends State<ItemDetailsPage> {
  
  ItemDetailsPageImplementation({Key key, this.itemId});

  String itemId;
  ItemDetails itemDetails;

  String availability = "Not specified";

  List<CategoryDetails> categoryDetails = [];
  List<ItemLocationDetails> itemLocationDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: getItemDetails()));
  }

  Widget getItemDetails() {
    return FutureBuilder(
        future: ItemService().getItemDetailsByItemId(itemId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            categoryDetails = [];
            itemLocationDetails = [];

            itemDetails = ItemDetails.fromJsonMap(snapshot.data['itemDetails']);
            availability = getAvailability(itemDetails.availability);

            for (var category in snapshot.data['categoryDetails']) {
              final item = new CategoryDetails.fromJsonMap(category);
              categoryDetails.add(item);
            }

            for (var itemLocation in snapshot.data['itemLocationDetails']) {
              final item = new ItemLocationDetails.fromJsonMap(itemLocation);
              itemLocationDetails.add(item);
            }

            return SingleChildScrollView(
                child: Column(children: <Widget>[
              itemQuestion(),
              getItemPhoto(context),
              createdDetails(),
              availabilityText(),
              availabilityList(context),
              locationsText(),
              locationsList(context),
              categoriesText(),
              categoriesList(context),
            ]));
          } else {
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        });
  }

  Widget categoriesText() {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Categories",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget locationsText() {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Where to find it",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget availabilityText() {
    return Container(
      margin: EdgeInsets.only(top: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Availability: " + availability,
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  String getAvailability(int availabilityParam) {
    switch (availabilityParam) {
      case Constants.ITEM_NO_AVAILABILITY:
        return "Buy";
      case Constants.ITEM_POOR_AVAILABILITY:
        return "Poor";
      case Constants.ITEM_FULL_AVAILABILITY:
        return "Full";
      default:
        return "Not defined";
    }
  }

  Widget availabilityList(context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        height: MediaQuery.of(context).size.height * 0.11,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == Constants.ITEM_NO_AVAILABILITY) {
                return noAvailabilityBtn(context);
              } else if (index == Constants.ITEM_POOR_AVAILABILITY) {
                return poorAvailabilityBtn(context);
              } else if (index == Constants.ITEM_FULL_AVAILABILITY) {
                return fullAvailabilityBtn(context);
              }
            }));
  }

  Widget locationsList(context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        height: MediaQuery.of(context).size.height * 0.11,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemLocationDetails.length,
            itemBuilder: (context, index) {
              return itemLocation(context, itemLocationDetails[index], index);
            }));
  }

  Widget categoriesList(context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        height: MediaQuery.of(context).size.height * 0.11,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryDetails.length,
            itemBuilder: (context, index) {
              return categoryInfo(context, categoryDetails[index], index);
            }));
  }

  Widget categoryInfo(context, CategoryDetails categoryDetails, index) {
    return Container(
        margin: index == 0
            ? const EdgeInsets.only(
                top: 25.0, bottom: 25.0, left: 25.0, right: 5.0)
            : const EdgeInsets.only(
                top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text(categoryDetails.name,
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
              onPressed: () => {null}),
        ));
  }

  Widget itemLocation(context, ItemLocationDetails itemLocationDetails, index) {
    return Container(
        margin: index == 0
            ? const EdgeInsets.only(
                top: 25.0, bottom: 25.0, left: 25.0, right: 5.0)
            : const EdgeInsets.only(
                top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text(itemLocationDetails.name,
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
              onPressed: () => {null}),
        ));
  }

  Widget noAvailabilityBtn(context) {
    return Container(
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, left: 25.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text("Buy",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(right: 50, left: 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFE74C3C)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFE74C3C)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFFE74C3C))))),
              onPressed: () => {updateAvailability(Constants.ITEM_NO_AVAILABILITY)}),
        ));
  }

  void updateAvailability(int availability){
    setState(() {
      ItemService().updateItemAvailability(itemId, availability).then((value) => {
      print(value),
      if (value == null){
        Utils.showToast("Something wrong happened, please try again later"),
      } else {
        Utils.showToast("Availability updated"),
        availability = getAvailability(value) as int,
      }
    });
    });
  }

  Widget poorAvailabilityBtn(context) {
    return Container(
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text("Poor",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(right: 50, left: 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFFFC300)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFFFC300)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFFFFC300))))),
              onPressed: () => {updateAvailability(Constants.ITEM_POOR_AVAILABILITY)}),
        ));
  }

  Widget fullAvailabilityBtn(context) {
    return Container(
        margin: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, left: 5.0, right: 5.0),
        child: SizedBox(
          child: TextButton(
              child: Text("Full",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(right: 50, left: 50)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF229954)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF229954)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFF229954))))),
              onPressed: () => {updateAvailability(Constants.ITEM_FULL_AVAILABILITY)}),
        ));
  }

  createdDetails() {
    String createdUserName =
        itemDetails.creatorFirstName + " " + itemDetails.creatorLastName;

    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 25.0, left: 25.0, right: 25.0),
      alignment: Alignment.center,
      child: Text(
        "Added by " + createdUserName,
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 18,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  getItemPhoto(context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.width * 0.6,
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(
                    "https://ep01.epimg.net/elpais/imagenes/2019/06/24/icon/1561369019_449523_1561456608_noticia_normal.jpg"))));
  }

  Widget itemQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        itemDetails.name,
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
