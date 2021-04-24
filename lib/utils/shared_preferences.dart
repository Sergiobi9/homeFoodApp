import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {

  getObjectFromStorage(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(key) == null){
      return null;
    }
    return jsonDecode(sharedPreferences.getString(key));
  }

  Future<bool> getBooleanFromStorage(String key) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  saveBooleanFromStorage(String key, value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  saveObjectFromStorage(String key, value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, json.encode(value));
  }

  removeObjectFromStorage(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }
}