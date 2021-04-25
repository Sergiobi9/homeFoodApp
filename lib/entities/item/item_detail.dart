class ItemDetail {
  
  String id;
  String name = "";
  
  ItemDetail() {}

  ItemDetail.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
  };

}
