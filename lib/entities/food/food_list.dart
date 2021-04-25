import 'package:home_food_project/entities/food/food_item.dart';

class FoodList {

  String categoryId;
  String categoryName = "";
  List<FoodItem> foodItems = [];

  FoodList() {}

  FoodList.fromJsonMap(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];

    for (var item in json['foodItems']){
      foodItems.add(FoodItem.fromJsonMap(item));
    }
  }

  Map toJson() => {
        'categoryId': categoryId,
        'categoryName': categoryName,
        'foodItems': foodItems,
      };
}
