class Item {
  String? id;
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;

  Item({
      this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price}
      );

  Item.fromJson(Map<String,dynamic> json)
  : id = json['id'],
  name = json['name'],
  description = json['description'],
  imageUrl = json['imageUrl'],
  price = json['price'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'price': price
  };
}