import 'package:flutter/material.dart';
import 'package:home_food_project/ui/item/register/register_item.dart';
import 'package:home_food_project/ui/item/register/register_item_image.dart';
import 'package:home_food_project/ui/item/register/register_item_locations_available.dart';
import 'package:home_food_project/utils/utils.dart';

class RegisterItemPricePage extends StatelessWidget {
  RegisterItemPricePage(
      {Key key, this.familyId, this.categoryId, this.categoryName})
      : super(key: key);

  String familyId;
  String categoryId;
  String categoryName;
  TextEditingController itemPriceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(children: <Widget>[
          itemNameQuestion(),
          itemPriceText(),
          itemPriceInput(),
          nextBtn(context)
        ])));
  }

  Widget itemPriceText() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Text(
          "Item price",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget nextBtn(BuildContext context) {
    return Container(
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
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(25)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFE18335)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFE18335)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFFE18335))))),
              onPressed: () => {nextStep(context)}),
        ));
  }

  void nextStep(context) {
    String itemPrice = itemPriceController.text;
    if (itemPrice == "" || itemPrice == null){
      Utils.showToast("Item price can not be empty");
      return;
    }

    RegisterItem.item.price = double.parse(itemPrice);

    Utils.navigateToNewScreen(context, RegisterItemLocationsAvailablePage());
  }

  Widget itemPriceInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: itemPriceController,
        keyboardType: TextInputType.number,
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
            contentPadding: EdgeInsets.only(
              top: 25, bottom: 25, right: 25,
              left: 25, // HERE THE IMPORTANT PART
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            fillColor: Color(0xFFF8F8F8)),
      ),
    );
  }

  Widget itemNameQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "How much does it cost?",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
