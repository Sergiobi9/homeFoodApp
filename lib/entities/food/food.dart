class Food {
  String id;
  String name = "";
  String familyId = "";
  String creatorUserId = "";
  String dateAdded = "";
  List<String> availableFoodLocationIds = [];

  Food() {}

  Food.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    familyId = json['familyId'];
    creatorUserId = json['creatorUserId'];
    dateAdded = json['dateAdded'];
    availableFoodLocationIds = json['availableFoodLocationIds'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'familyId': familyId,
        'creatorUserId': creatorUserId,
        'dateAdded': dateAdded,
        'availableFoodLocationIds': availableFoodLocationIds
      };
}
