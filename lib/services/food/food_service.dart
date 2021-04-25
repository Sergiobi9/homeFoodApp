import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/food/food.dart';
import 'package:home_food_project/entities/food/food_list.dart';
import 'package:home_food_project/utils/date_utils.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_provider.dart';

class FoodService {
  String foodEndpoint = ApiProvider().getApiUrl();

  Future<List<FoodList>> getFoodListWithCategories(String familyId) async {
    final response = await http.get(
        Uri.http(foodEndpoint, "food/all/list/familyId/${familyId}"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));

      List<FoodList> foodList = [];

      for (var foodListItem in decodedData) {
        final item = new FoodList.fromJsonMap(foodListItem);
        foodList.add(item);
      }

      return foodList;
    } else {
      return null;
    }
  }

  Future<dynamic> registerFood(Food food) async {

    food.name = Utils.capitalize(food.name);
    String userId = "";

    await SharedPref()
        .getStringFromStorage("userId")
        .then((value) => userId = value);

    food.creatorUserId = userId;
    food.dateAdded = DateUtilsHelper.timeStamp();

    var foodBody = jsonEncode(food.toJson());

    final response = await http.post(
        Uri.http(foodEndpoint, "food/register"),
        headers: {"Content-Type": "application/json",},
        body: foodBody);

    if (response.statusCode == 200) {
      if (response.body.contains(Constants.SUCCESS)) {
        return Constants.SUCCESS;
      } else {
        return Constants.RESPONSE_NOT_SUCCESS;
      }
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }
}
