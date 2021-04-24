import 'package:home_food_project/entities/family/family_member_detailed.dart';
import 'package:home_food_project/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_provider.dart';

class FamilyMemberService {
  String familyMemberEndpoint = ApiProvider().getApiUrl();

  Future<dynamic> getFamilyMembers() async {
     String userId = "";

    await SharedPref()
        .getStringFromStorage("userId")
        .then((value) => userId = value);

    final response = await http.get(
        Uri.http(familyMemberEndpoint, "family/members/userId/${userId}"),
        headers: {"Content-Type": "application/json"});

    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      return decodedData;
    } else {
      return null;
    }
  }
}
