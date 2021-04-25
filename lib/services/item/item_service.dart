import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/item/item.dart';
import 'package:home_food_project/entities/item/item_list.dart';
import 'package:home_food_project/utils/date_utils.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:home_food_project/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_provider.dart';

class ItemService {
  String itemEndpoint = ApiProvider().getApiUrl();

  Future<List<ItemList>> getItemListWithCategories(String familyId) async {
    final response = await http.get(
        Uri.http(itemEndpoint, "item/all/list/familyId/${familyId}"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));

      List<ItemList> itemList = [];

      for (var itemListItem in decodedData) {
        final item = new ItemList.fromJsonMap(itemListItem);
        itemList.add(item);
      }

      return itemList;
    } else {
      return null;
    }
  }

  Future<dynamic> registerItemToCategory(Item item, String categoryId) async {
    item.name = Utils.capitalize(item.name);
    String userId = "";

    await SharedPref()
        .getStringFromStorage("userId")
        .then((value) => userId = value);

    item.creatorUserId = userId;
    item.dateAdded = DateUtilsHelper.timeStamp();

    var itemBody = jsonEncode(item.toJson());

    final response = await http.post(
        Uri.http(itemEndpoint, "item/register/categoryId/${categoryId}"),
        headers: {
          "Content-Type": "application/json",
        },
        body: itemBody);

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

  Future<dynamic> getItemDetailsByItemId(String itemId) async {
    final response = await http.get(
        Uri.http(itemEndpoint, "item/detailed/itemId/${itemId}"),
        headers: {
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      return decodedData;
    } else {
      return null;
    }
  }

  Future<dynamic> updateItemAvailability(String itemId, int availability) async {

    final response = await http.put(
        Uri.http(itemEndpoint,
            "item/update/itemId/${itemId}/availability/${availability}"),
        headers: {
          "Content-Type": "application/json",
        });

    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      return decodedData;
    } else {
      return null;
    }
  }
}
