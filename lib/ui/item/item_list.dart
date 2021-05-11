import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/category/category.dart';
import 'package:home_food_project/entities/item/item_details.dart';
import 'package:home_food_project/entities/item/item_list.dart';
import 'package:home_food_project/services/category/category_service.dart';
import 'package:home_food_project/services/family/family_member_service.dart';
import 'package:home_food_project/services/item/item_service.dart';
import 'package:home_food_project/ui/category/register/register_category_name.dart';
import 'package:home_food_project/ui/item/register/register_item_name.dart';
import 'package:home_food_project/utils/utils.dart';

import 'details/item_details.dart';

class ItemListPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ItemListPage> {
  List<ItemList> itemList = [];
  String familyId;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          goMain();
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: SingleChildScrollView(child: getFamilyInfo()))));
  }

  goMain() {
    Utils().filterUser(context);
  }

  Widget getFamilyInfo() {
    return FutureBuilder(
        future: FamilyMemberService().getFamilyMembers(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            familyId = snapshot.data['familyId'];
            String familyName = snapshot.data['familyName'];

            return Column(children: <Widget>[
              backIcon(),
              familyNameText(familyName),
              manageCategoriesAndSupermarketsButtons(familyId),
              categoriesAndItems(familyId),
            ]);
          } else {
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        });
  }

  Widget backIcon() {
    return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 30,
            ),
            onPressed: () {
              goMain();
            }));
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
                        child: Text("Add category",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal)),
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
            /*     Container(
                width: MediaQuery.of(context).size.width * 0.43,
                margin: EdgeInsets.only(left: 10),
                child: SizedBox(
                    child: TextButton(
                        child: Text("Add location",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal)),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFC16E70)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFC16E70)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        BorderSide(color: Color(0xFFC16E70))))),
                        onPressed: () => {null}))) */
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
      margin: EdgeInsets.only(top: 10.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        endsWithS ? familyName + "' items list" : familyName + "'s items list",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget categoriesAndItems(familyId) {
    return FutureBuilder(
        future: ItemService().getItemListWithCategories(familyId),
        builder:
            (BuildContext context, AsyncSnapshot<List<ItemList>> snapshot) {
          if (snapshot.hasData) {
            itemList = snapshot.data;
            return Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                          child: Container(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    categoryInfo(itemList[index]),
                                    categoryItemListItems(
                                        itemList[index].itemDetails,
                                        itemList[index].categoryId,
                                        itemList[index].categoryName)
                                  ]))));
                    }));
          } else {
            return Container();
          }
        });
  }

  Widget categoryInfo(ItemList itemList) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          margin: EdgeInsets.only(top: 5.0, right: 15.0),
          alignment: Alignment.centerLeft,
          child: Text(
            itemList.categoryName == "" ? "Others" : itemList.categoryName,
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        if (itemList.categoryName != "") Container(
            margin: EdgeInsets.only(left: 10),
            child: IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 25,
                ),
                onPressed: () {
                  deleteCategory(itemList.categoryId);
                }))
      ],
    );
  }

  deleteCategory(categoryId){
    CategoryService().deleteCategoryById(categoryId).then((value) => {
      if (value == Constants.SUCCESS){
        Utils.navigatePage(context, ItemListPage())
      } else{
        Utils.showToast("Something went wrong, try again later")
      }
    });
  }

  categoryItemListItems(
      List<ItemDetails> items, String categoryId, String categoryName) {
    if (items.length == 0) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.43,
          margin: EdgeInsets.only(top: 25, bottom: 25),
          child: SizedBox(
              child: TextButton(
                  child: Text("Add item",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal)),
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
                      {addItemToCategory(categoryId, categoryName)})));
    } else {
      return Container(
          margin: EdgeInsets.only(right: 5, left: 5, top: 15),
          child: Column(children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return new GestureDetector(
                      onTap: () {
                        showItemInfo(items[index].id);
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(children: [
                                getItemInfo(items[index]),
                                if (index == items.length - 1)
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      margin:
                                          EdgeInsets.only(top: 25, bottom: 25),
                                      child: SizedBox(
                                          child: TextButton(
                                              child: Text("Add item",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              style: ButtonStyle(
                                                  foregroundColor: MaterialStateProperty.all<Color>(
                                                      Color(0xFFE18335)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                          Color(0xFFE18335)),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(25.0),
                                                          side: BorderSide(color: Color(0xFFE18335))))),
                                              onPressed: () => {addItemToCategory(categoryId, categoryName)})))
                              ]))));
                }),
          ]));
    }
  }

  showItemInfo(String itemId) {
    Utils.navigateToNewScreen(context, ItemDetailsPage(itemId: itemId));
  }

  Widget getItemInfo(ItemDetails item) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [itemImage(item), getItemName(item)],
        ));
  }

  getItemName(ItemDetails item) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.22,
      margin: EdgeInsets.only(left: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(5.0),
                child: Text(item.name,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ]),
    );
  }

  Widget itemImage(ItemDetails item) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.15,
            child: Image.asset(
              getItemImage(),
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
            )),
        if (item.availability == 0)
          buyItemImage(MediaQuery.of(context).size.width),
      ],
    );
  }

  String getItemImage() {
    Random random = new Random();
    int randomNumber = random.nextInt(4); // from 0 upto 99 included

    print(randomNumber);
    if (randomNumber > 0 && randomNumber < 1) {
      return "assets/fruits.png";
    } else if (randomNumber >= 1 && randomNumber < 2) {
      return "assets/pancakes.png";
    } else {
      return "assets/healthy-food.png";
    }
  }

  Widget buyItemImage(bodyHeight) {
    return Container(
      width: bodyHeight * 0.2,
      height: bodyHeight * 0.15,
      child: Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/buy.png",
            height: 35,
            width: 35,
            fit: BoxFit.cover,
          )),
    );
  }

  dynamic addItemToCategory(categoryId, categoryName) {
    Utils.navigateToNewScreen(
        context,
        RegisterItemNamePage(
            familyId: familyId,
            categoryId: categoryId,
            categoryName: categoryName));
  }

  removeUserFromFamily(index) {
    setState(() {
      itemList.removeAt(index);
    });
  }
}
