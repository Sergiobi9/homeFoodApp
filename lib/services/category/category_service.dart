import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/category/category.dart';
import 'package:home_food_project/entities/family/family_member_detailed.dart';
import 'package:home_food_project/utils/date_utils.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_provider.dart';

class CategoryService {
  String categoryEndpoint = ApiProvider().getApiUrl();

  Future<dynamic> registerCategory(String familyId, String categoryName) async {

    categoryName = Utils.capitalize(categoryName);
    String userId = "";

    await SharedPref()
        .getStringFromStorage("userId")
        .then((value) => userId = value);

    Category category = Category(categoryName, familyId, userId);
    var categoryRegisteredBody = jsonEncode(category.toJson());

    final response = await http.post(
        Uri.http(categoryEndpoint, "category/register"),
        headers: {"Content-Type": "application/json"},
        body: categoryRegisteredBody);

    if (response.statusCode == 200) {
      if (response.body.contains(Constants.SUCCESS)) {
        return Constants.SUCCESS;
      } else if (response.body.contains(Constants.CATEGORY_EXISTS)) {
        return Constants.CATEGORY_EXISTS;
      } else {
        return Constants.RESPONSE_NOT_SUCCESS;
      }
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }
}
