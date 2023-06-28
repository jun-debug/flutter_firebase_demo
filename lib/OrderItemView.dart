import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/ItemListView.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/item.dart';

class OrderItemView extends StatelessWidget {
  const OrderItemView({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<OrderRepository>(context, listen: true);
    List<Item> items = [];
    List<int> quantities = [];
    for(var entry in cart.currentOrder.items.entries){
      items.add(entry.key);
      quantities.add(entry.value);
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ItemListView(items: items, quantities: quantities),
        //FutureBuilder<Map<Item,int>>(
        //   future: Provider.of<OrderRepository>(context, listen: true).getOrderItems(),
        //   builder: (context, AsyncSnapshot<Map<Item,int>> itemMap) {
        //     if (itemMap.hasData && !itemMap.data!.isEmpty){
        //       Map<Item, int> cartItemMap = itemMap.data!;
        //       List<Item> items = [];
        //       List<int> quantities = [];
        //       cartItemMap.entries.forEach((element) {
        //         items.add(element.key);
        //         quantities.add(element.value);
        //       });
        //       return ItemListView(items: items, quantities: quantities);
        //     }
        //     else {
        //       return const CircularProgressIndicator();
        //     }
        //   },
        // )

    );
  }
}

// ListView.builder(
//  itemCount: items.length,
//  itemBuilder: (context, index) {
//    return Card(
//      child: ListTile(
//        leading: Image.network(
//          items[index].imageUrl ?? "",
//          width: 100,
//          height: 100,
//          fit: BoxFit.fill,
//        ),
//        title: Text(items[index].name),
//        subtitle: Text(items[index].description ?? ""),
//        trailing: Row(
//          mainAxisSize: MainAxisSize.min,
//          children: [
//            Text('Quantity: ${quantities[index]}'),
//            IconButton(
//              icon: const Icon(Icons.remove),
//              onPressed: () {
//                cart.deleteItem(itemId: items[index].id!);
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  },
// ),