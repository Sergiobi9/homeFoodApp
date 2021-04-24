
import 'package:home_food_project/entities/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserSession {
  
  String token;
  User user;
  String info;

  UserSession() {}

  UserSession.fromJsonMap(Map<String, dynamic> json) {
    token = json['token'];
    user = User.fromJsonMap(json['user']);
    info = json['info'];
  }

  @override
  String toString() {
    return token + "/" + user.toString();
  }

  Map toJson() => {
        'token': token,
        'user': user,
        'info': info,
      };
}
