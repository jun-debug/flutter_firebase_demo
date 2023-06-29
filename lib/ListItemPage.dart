import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/ItemListView.dart';
import 'package:flutter_firebase_demo/OrderDetailPage.dart';
import 'package:flutter_firebase_demo/model/ItemRepository.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/item.dart';

/* **********************************************************
load and show all fitness equipments
************************************************************ */

class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<OrderRepository>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              semanticLabel: 'menu',
            ),
            onPressed: () {},
          ),
          title: const Text('Shop fitness equipments'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                semanticLabel: 'Search item',
              ),
              onPressed: () {},
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    semanticLabel: 'Shopping cart',
                  ),
                  onPressed: () {
                    if (cart.currentOrder.items.isNotEmpty) {
                      //cart.saveOrder();
                      //Navigator.pushNamed(context, 'OrderItemList');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailPage(),
                        ),
                      );
                    }
                  },
                ),
                if (cart.count > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                      child: Text(
                        cart.count.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.home,
                semanticLabel: 'back to homepage',
              ),
              onPressed: () {
                  Navigator.pushNamed(context, 'Home');
              },
            ),
          ],
        ),
        body: FutureBuilder<List<Item>>(
          future: Provider.of<ItemRepository>(context, listen: true).getAllItems(),
          builder: (context, AsyncSnapshot<List<Item>> items) {
            if (items.hasData) {
              return ItemListView(items: items.data!);
            }
            else {
              return const CircularProgressIndicator();
            }
          },
        )
    );
  }
}