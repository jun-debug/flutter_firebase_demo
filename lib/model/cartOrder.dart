
class CartOrder {
  String? id;
  Map<String, int> items = {};

  CartOrder({this.id});


  CartOrder.fromJson(Map<String,dynamic> json)
      : id = json['id'],
        items = json['order_items'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_items': items
  };
}