import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/food_location/food_location.dart';
import 'package:home_food_project/entities/food_location/food_location_register_simplified.dart';
import 'package:home_food_project/entities/food_location/food_location_simplified.dart';
import 'package:home_food_project/utils/date_utils.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_provider.dart';

class FoodLocationService {
  String foodLocationEndpoint = ApiProvider().getApiUrl();

  Future<List<FoodLocationSimplified>> getFamilyFoodLocations(
      String familyId) async {
    final response = await http.get(
        Uri.http(
            foodLocationEndpoint, "food/location/all/familyId/${familyId}"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));

      List<FoodLocationSimplified> foodLocations = [];

      for (var foocLocation in decodedData) {
        final location = new FoodLocationSimplified.fromJsonMap(foocLocation);
        foodLocations.add(location);
      }

      return foodLocations;
    } else {
      return null;
    }
  }

  Future<dynamic> registerFoodLocationName(
      FoodLocationRegisterSimplified foodLocationRegisterSimplified) async {

    foodLocationRegisterSimplified.name =
        Utils.capitalize(foodLocationRegisterSimplified.name);
    String userId = "";

    await SharedPref()
        .getStringFromStorage("userId")
        .then((value) => userId = value);

    foodLocationRegisterSimplified.creatorId = userId;
    foodLocationRegisterSimplified.dateAdded = DateUtilsHelper.timeStamp();

    var foodLocationBody = jsonEncode(foodLocationRegisterSimplified.toJson());

    final response = await http.post(
        Uri.http(foodLocationEndpoint, "food/location/register/name"),
        headers: {"Content-Type": "application/json"},
        body: foodLocationBody);

    if (response.statusCode == 200) {
      bool foodLocationExists = response.body.length == 0;
      if (foodLocationExists) {
        return Constants.FOOD_LOCATION_EXISTS;
      } else {
        final decodedData = json.decode(utf8.decode(response.bodyBytes));
        final foodLocationRegisterSimplified = new FoodLocationSimplified.fromJsonMap(decodedData);
        return foodLocationRegisterSimplified;
      }
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }

  Future<dynamic> registerFoodLocation(FoodLocation foodLocation) async {
    var foodLocationBody = jsonEncode(foodLocation.toJson());

    final response = await http.post(
        Uri.http(foodLocationEndpoint, "food/location/register"),
        headers: {"Content-Type": "application/json"},
        body: foodLocationBody);

    if (response.statusCode == 200) {
      if (response.body.contains(Constants.SUCCESS)) {
        return Constants.SUCCESS;
      } else if (response.body.contains(Constants.FOOD_LOCATION_EXISTS)) {
        return Constants.FOOD_LOCATION_EXISTS;
      } else {
        return Constants.RESPONSE_NOT_SUCCESS;
      }
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }
}
