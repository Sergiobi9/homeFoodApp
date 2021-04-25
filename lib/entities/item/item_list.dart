import 'item_details.dart';

class ItemList {

  String categoryId;
  String categoryName = "";
  List<ItemDetails> itemDetails = [];

  ItemList() {}

  ItemList.fromJsonMap(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];

    for (var item in json['itemDetails']){
      itemDetails.add(ItemDetails.fromJsonMap(item));
    }
  }

  Map toJson() => {
        'categoryId': categoryId,
        'categoryName': categoryName,
        'itemDetails': itemDetails,
      };
}
