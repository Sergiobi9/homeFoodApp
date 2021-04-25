import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CategoryDetails {

  String id;
  String name = "";

  CategoryDetails() {}

  CategoryDetails.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
      };
}
