import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/ItemCard.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/item.dart';

class OrderItemListView extends StatelessWidget {
  List<Item> items;
  List<int> quantities;

  OrderItemListView({super.key, required this.items, required this.quantities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemCard(item: items[index], qty: quantities[index]);
        }
    );
  }
}