import 'package:flutter/material.dart';
import 'package:home_food_project/ui/item/register/register_item.dart';
import 'package:home_food_project/ui/item/register/register_item_image.dart';
import 'package:home_food_project/utils/utils.dart';

class ItemDetailsPage extends StatelessWidget {
  ItemDetailsPage(
      {Key key, this.itemId})
      : super(key: key);

  String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(children: <Widget>[
          itemQuestion(),
        ])));
  }

  Widget itemQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "Ice cream",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
