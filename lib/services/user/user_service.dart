import 'package:home_food_project/entities/user.dart';
import 'package:home_food_project/entities/user_session.dart';
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

    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      final user = new UserSession.fromJsonMap(decodedData);
      return user;
    } else {
      return null;
    }
  }
}
