import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/item.dart';

class ItemListView extends StatelessWidget{
  final List<Item> items;
  const ItemListView({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        TextEditingController quantityController = TextEditingController();
        return
          Card(
          elevation: 4.0,
          child: Column (
            children: [
              SizedBox(
                 width: 200,
                 height: 200,
                 child: Image.network(items[index].imageUrl!,
                  fit: BoxFit.fill,),
              ),
              ListTile(
                title: Text(items[index].name),
                subtitle: Text(items[index].description ?? ""),
                trailing: Text('\$${items[index].price.toStringAsFixed(2)}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: 'Quantity',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        var itemId = items[index].id;
                        int qty = int.tryParse(quantityController.text)??1;
                        Provider.of<OrderRepository>(context, listen: false).addItem(itemId: itemId!, qty: qty);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}