import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/family/family_register.dart';
import 'package:home_food_project/utils/date_utils.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_provider.dart';

class FamilyService {
  String familyEndpoint = ApiProvider().getApiUrl();

  Future<dynamic> registerFamily(FamilyRegister familyRegister) async {
    String userId = "";

    await SharedPref()
        .getStringFromStorage("userId")
        .then((value) => userId = value);

    String currentDate = DateUtilsHelper.timeStamp();

    familyRegister.family.ownerId = userId;

    var familyRegisterBody = jsonEncode(familyRegister.toJson());

    final response = await http.post(Uri.http(familyEndpoint, "family/register/${currentDate}"),
        headers: {"Content-Type": "application/json"},
        body: familyRegisterBody);

    print(response.statusCode);
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
