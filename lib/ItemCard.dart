import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/ItemDetailPage.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final int qty;
  const ItemCard({super.key, required this.item, required this.qty});
  
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailPage(item: item),
            ),
          );
        },
        child: Card(
          elevation: 4.0, // Adjust the elevation for the desired shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  width: 100,
                  height: 100,
                  child: Image.network(
                      item.imageUrl ?? ""), // Replace with your image path
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Price:\$${item.price}    Quantity: $qty',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    var cart = Provider.of<OrderRepository>(
                        context, listen: false);
                    cart.deleteItem(item: item);
                  },
                ),
              ],
            ),
          ),
        ),
      );
  }
}
