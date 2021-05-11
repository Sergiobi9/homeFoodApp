class ItemDetails {
  String id;
  String name = "";
  String creatorFirstName;
  String creatorLastName;
  String registeredDate;
  double price;
  int availability;

  ItemDetails() {}

  ItemDetails.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    creatorFirstName = json['creatorFirstName'];
    creatorLastName = json['creatorLastName'];
    registeredDate = json['registeredDate'];
    price = json['price'];
    availability = json['availability'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'creatorFirstName': creatorFirstName,
        'creatorLastName': creatorLastName,
        'registeredDate': registeredDate,
        'price': price,
        'availability': availability,
      };
}
