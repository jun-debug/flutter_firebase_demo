import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final int qty;
  const ItemCard({super.key, required this.item, required this.qty});
  
  @override
  Widget build(BuildContext context) {
    return Card(
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
              child: Image.network('path_to_your_image.png'), // Replace with your image path
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
                    'Quantity: $qty',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                var cart =Provider.of<OrderRepository>(context, listen: false);
                cart.deleteItem(item: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
