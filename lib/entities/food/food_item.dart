class FoodItem {
  String id;
  String name = "";
  
  FoodItem() {}

  FoodItem.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
  };

}
