import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/item_location/item_location.dart';
import 'package:home_food_project/entities/item_location/item_location_register_simplified.dart';
import 'package:home_food_project/entities/item_location/item_location_simplified.dart';
import 'package:home_food_project/utils/date_utils.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_provider.dart';

class ItemLocationService {
  String itemLocationEndpoint = ApiProvider().getApiUrl();

  Future<List<ItemLocationSimplified>> getFamilyItemLocations(
      String familyId) async {
    final response = await http.get(
        Uri.http(
            itemLocationEndpoint, "item/location/all/familyId/${familyId}"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));

      List<ItemLocationSimplified> itemLocations = [];

      for (var itemLocation in decodedData) {
        final item = new ItemLocationSimplified.fromJsonMap(itemLocation);
        itemLocations.add(item);
      }

      return itemLocations;
    } else {
      return null;
    }
  }

  Future<dynamic> registerItemLocationName(
      ItemLocationRegisterSimplified itemLocationRegisterSimplified) async {

    itemLocationRegisterSimplified.name =
        Utils.capitalize(itemLocationRegisterSimplified.name);
    String userId = "";

    await SharedPref()
        .getStringFromStorage("userId")
        .then((value) => userId = value);

    itemLocationRegisterSimplified.creatorId = userId;
    itemLocationRegisterSimplified.dateAdded = DateUtilsHelper.timeStamp();

    var itemLocationBody = jsonEncode(itemLocationRegisterSimplified.toJson());

    final response = await http.post(
        Uri.http(itemLocationEndpoint, "item/location/register/name"),
        headers: {"Content-Type": "application/json"},
        body: itemLocationBody);

    if (response.statusCode == 200) {
      bool itemLocationExists = response.body.length == 0;
      if (itemLocationExists) {
        return Constants.ITEM_LOCATION_EXISTS;
      } else {
        final decodedData = json.decode(utf8.decode(response.bodyBytes));
        final itemLocationRegisterSimplified = new ItemLocationSimplified.fromJsonMap(decodedData);
        return itemLocationRegisterSimplified;
      }
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }

  Future<dynamic> registerItemLocation(ItemLocation itemLocation) async {
    var itemLocationBody = jsonEncode(itemLocation.toJson());

    final response = await http.post(
        Uri.http(itemLocationEndpoint, "item/location/register"),
        headers: {"Content-Type": "application/json"},
        body: itemLocationBody);

    if (response.statusCode == 200) {
      if (response.body.contains(Constants.SUCCESS)) {
        return Constants.SUCCESS;
      } else if (response.body.contains(Constants.ITEM_LOCATION_EXISTS)) {
        return Constants.ITEM_LOCATION_EXISTS;
      } else {
        return Constants.RESPONSE_NOT_SUCCESS;
      }
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }
}
