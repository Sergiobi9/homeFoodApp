import 'package:flutter/material.dart';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/services/category/category_service.dart';
import 'package:home_food_project/ui/family/register/register_family.dart';
import 'package:home_food_project/ui/family/register/register_family_members.dart';
import 'package:home_food_project/ui/food/food_list.dart';
import 'package:home_food_project/utils/utils.dart';

class RegisterCategoryNamePage extends StatelessWidget {
  RegisterCategoryNamePage({Key key, this.familyId}) : super(key: key);

  String familyId;
  TextEditingController categoryNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(children: <Widget>[
          categoryNameQuestion(),
          categoryNameText(),
          categoryNameInput(),
          nextBtn(context)
        ])));
  }

  Widget categoryNameText() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, right: 25, left: 25),
        alignment: Alignment.topLeft,
        child: Text(
          "Category name",
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
                      MaterialStateProperty.all<Color>(Color(0xFF274060)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF274060)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xFF274060))))),
              onPressed: () => {registerCategory(context)}),
        ));
  }

  void registerCategory(context) {
    String categoryName = categoryNameController.text;

    CategoryService().registerCategory(familyId, categoryName).then((value) => {
          if (value == Constants.CATEGORY_EXISTS)
            {Utils.showToast("This category already exists")}
          else if (value == Constants.SUCCESS)
            {redirectFoodList(context)}
          else
            {Utils.showToast("Something went wrong, try again later")}
        });
  }

  void redirectFoodList(context) {
    Utils.showToast("Category added");
    Utils.navigatePage(context, FoodListPage());
  }

  Widget categoryNameInput() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: categoryNameController,
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

  Widget categoryNameQuestion() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 25.0, left: 25.0, right: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "How do you want to name your new category?",
        style: TextStyle(
            color: Color(0xff333333),
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
