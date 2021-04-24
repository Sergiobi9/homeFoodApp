class Family {
  String id;
  String name = "";
  String ownerId = "";
  String dateRegistered = "";

  Family() {}

  Family.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ownerId = json['ownerId'];
    dateRegistered = json['dateRegistered'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'ownerId': ownerId,
        'dateRegistered': dateRegistered
      };
}
