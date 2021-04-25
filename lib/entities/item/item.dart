class Item {
  String id;
  String name = "";
  String familyId = "";
  String creatorUserId = "";
  String dateAdded = "";
  int availability = -1;
  List<String> availableItemLocationIds = [];

  Item() {}

  Item.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    familyId = json['familyId'];
    creatorUserId = json['creatorUserId'];
    dateAdded = json['dateAdded'];
    availability = json['availability'];
    availableItemLocationIds = json['availableItemLocationIds'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'familyId': familyId,
        'creatorUserId': creatorUserId,
        'dateAdded': dateAdded,
        'availability': availability,
        'availableItemLocationIds': availableItemLocationIds
      };
}
