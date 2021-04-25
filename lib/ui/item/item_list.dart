import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/family/family_member_detailed.dart';
import 'package:home_food_project/entities/item/item_detail.dart';
import 'package:home_food_project/entities/item/item_list.dart';
import 'package:home_food_project/services/family/family_member_service.dart';
import 'package:home_food_project/services/item/item_service.dart';
import 'package:home_food_project/ui/category/register/register_category_name.dart';
import 'package:home_food_project/ui/item/register/register_item_name.dart';
import 'package:home_food_project/utils/utils.dart';

class ItemListPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ItemListPage> {
  List<ItemList> itemList = [];
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
              categoriesAndItems(familyId),
            ]);
          } else {
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
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
            itemList= snapshot.data;
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
                                    categoryName(itemList[index].categoryName),
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

  Widget categoryName(categoryName) {
    return Container(
      margin: EdgeInsets.only(top: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        categoryName == "" ? "Others" : categoryName,
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  categoryItemListItems(
      List<ItemDetail> items, String categoryId, String categoryName) {
    print(items.length);
    if (items.length == 0) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.43,
          margin: EdgeInsets.only(top: 25, bottom: 25),
          child: SizedBox(
              child: TextButton(
                  child: Text("Add item".toUpperCase(),
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
                      {addItemToCategory(categoryId, categoryName)})));
    } else {
      return Container(
          margin: EdgeInsets.only(right: 5, left: 5, top: 15),
          child: Column(children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return new GestureDetector(
                      child: Container(
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
                                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0), side: BorderSide(color: Color(0xFFE18335))))),
                                              onPressed: () => {addItemToCategory(categoryId, categoryName)})))
                              ]))));
                }),
          ]));
    }
  }

  Widget getItemInfo(ItemDetail food) {
    return Container(
      alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
      children: [itemImage(), getItemName(food)],
    ));
  }

  getItemName(ItemDetail food) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.2,
      margin: EdgeInsets.only(left: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(5.0),
                child: Text(food.name,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ]),
    );
  }

  Widget itemImage() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.width * 0.15,
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(
                    "https://ep01.epimg.net/elpais/imagenes/2019/06/24/icon/1561369019_449523_1561456608_noticia_normal.jpg"))));
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
