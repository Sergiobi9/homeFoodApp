import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/family/family_member_user_request.dart';
import 'package:home_food_project/entities/user/user.dart';
import 'package:home_food_project/entities/user/user_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_provider.dart';

class UserService {
  String userEndpoint = ApiProvider().getApiUrl();

  Future<UserSession> registerUser(User userRegistered) async {
    var userRegisteredBody = jsonEncode(userRegistered.toJson());

    final response = await http.post(Uri.http(userEndpoint, "user/register"),
        headers: {"Content-Type": "application/json"},
        body: userRegisteredBody);

    print(userRegisteredBody);

    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final user = new UserSession.fromJsonMap(decodedData);
      return user;
    } else {
      return null;
    }
  }

  Future<dynamic> checkUserAlreadyExists(String email) async {
    final response = await http.get(
        Uri.http(userEndpoint, "user/exist/email/${email}"),
        headers: {"Content-Type": "application/json"});

    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.contains(Constants.USER_EXISTS)) {
        return Constants.USER_EXISTS;
      } else if (response.body.contains(Constants.USER_DO_NOT_EXIST)) {
        return Constants.USER_DO_NOT_EXIST;
      } else {
        return Constants.RESPONSE_NOT_SUCCESS;
      }
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }

  Future<dynamic> checkUserExistToBeFamilyMember(String identifier) async {
    final response = await http.get(
        Uri.http(userEndpoint, "user/request/family/member/${identifier}"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      bool userDoNotExist = response.body.length == 0;
      if (userDoNotExist) {
        return Constants.USER_DO_NOT_EXIST;
      } else {
        final decodedData = json.decode(utf8.decode(response.bodyBytes));
        final user = new FamilyMemberUserRequest.fromJsonMap(decodedData);
        return user;
      }
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }
}
