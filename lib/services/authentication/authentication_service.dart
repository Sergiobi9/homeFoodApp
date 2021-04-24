import 'dart:convert';
import 'package:home_food_project/constants/constants.dart';
import 'package:home_food_project/entities/authentication/authentication_data.dart';
import 'package:home_food_project/entities/user/user_session.dart';

import '../api_provider.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  String authenticationEndpoint = ApiProvider().getApiUrl();

  Future<dynamic> doLogin(AuthenticationData authenticationData) async {
    var authenticationDataJson = jsonEncode(authenticationData.toJson());

    final response = await http.post(Uri.http(authenticationEndpoint, "auth/login"),
        headers: {"Content-Type": "application/json"},
        body: authenticationDataJson);

        print("Hols");

    if (response.statusCode == 200) {
      if (response.body.contains(Constants.USER_DO_NOT_EXIST)) {
        return Constants.USER_DO_NOT_EXIST;
      } else {
        final decodedData = json.decode(utf8.decode(response.bodyBytes));
        final user = new UserSession.fromJsonMap(decodedData);
        return user;
      }
    } else if (response.statusCode == 401) {
      return Constants.RESPONSE_NOT_AUTHORIZED;
    } else {
      return Constants.RESPONSE_NOT_SUCCESS;
    }
  }
}
