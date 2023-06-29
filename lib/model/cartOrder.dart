
import 'item.dart';

class CartOrder {
  String? id;
  // Map<String, int> items = {};
  Map<Item, int> items = {};

  String? userId;


  CartOrder({this.id});


  // CartOrder.fromJson(Map<String,dynamic> json)
  //     : id = json['id'],
  //       items = json['order_items'];

  // Map<String, dynamic> toJson() => {
  //   'id': id,
  //   'order_items': items
  // };




  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      //'orderItems': items.map((item, quantity) => MapEntry(item.toJson(), quantity)),
      'orderItems': items.map((item, quantity) => MapEntry(item.toJson(), quantity))
          .map((key, value) => MapEntry(key.toString(), value)),
    };
  }

  CartOrder.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      userId = json['userId'],
      items = json['orderItems'].map<Item, int>((itemJson, quantity) =>
          MapEntry(Item.fromJson(itemJson), quantity));

}