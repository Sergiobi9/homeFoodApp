import 'package:home_food_project/utils/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category_food_register.dart';

@JsonSerializable()
class Category {

  String id;
  String name = "";
  String familyId = "";
  String creatorUserId = "";
  String dateAdded = "";
  List<CategoryFoodRegister> foodItems;

  Category(String name, String familyId, String creatorUserId) {
    this.name = name;
    this.familyId = familyId;
    this.creatorUserId = creatorUserId;
    this.dateAdded = DateUtilsHelper.timeStamp();
    this.foodItems = [];
  }

  Category.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    familyId = json['familyId'];
    creatorUserId = json['creatorUserId'];
    dateAdded = json['dateAdded'];
    foodItems = json['foodItems'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'familyId': familyId,
        'creatorUserId': creatorUserId,
        'dateAdded': dateAdded,
        'foodItems':foodItems,
      };
}
