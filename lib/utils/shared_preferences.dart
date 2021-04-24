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

  Future<String> getStringFromStorage(String key) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  saveStringToStorage(String key, value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<bool> getBooleanFromStorage(String key) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  saveBooleanToStorage(String key, value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  saveObjectToStorage(String key, value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, json.encode(value));
  }

  removeObjectFromStorage(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }
}