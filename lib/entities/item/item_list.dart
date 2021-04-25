import 'item_detail.dart';

class ItemList {

  String categoryId;
  String categoryName = "";
  List<ItemDetail> itemDetails = [];

  ItemList() {}

  ItemList.fromJsonMap(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];

    for (var item in json['itemDetails']){
      itemDetails.add(ItemDetail.fromJsonMap(item));
    }
  }

  Map toJson() => {
        'categoryId': categoryId,
        'categoryName': categoryName,
        'itemDetails': itemDetails,
      };
}
