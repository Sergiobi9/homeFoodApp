class Family {
  String id;
  String name = "";
  String ownerId = "";

  Family() {}

  Family.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ownerId = json['ownerId'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'ownerId': ownerId,
      };
}
