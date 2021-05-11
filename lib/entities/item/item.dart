class Item {
  String id;
  String name = "";
  String familyId = "";
  String creatorUserId = "";
  String dateAdded = "";
  int availability = -1;
  double price = 0;
  List<String> availableItemLocationIds = [];

  Item() {}

  Item.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    familyId = json['familyId'];
    creatorUserId = json['creatorUserId'];
    dateAdded = json['dateAdded'];
    availability = json['availability'];
    price = json['price'];
    availableItemLocationIds = json['availableItemLocationIds'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'familyId': familyId,
        'creatorUserId': creatorUserId,
        'dateAdded': dateAdded,
        'availability': availability,
        'price': price,
        'availableItemLocationIds': availableItemLocationIds
      };
}
