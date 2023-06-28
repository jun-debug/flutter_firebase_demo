import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/item.dart';

class ItemListView extends StatelessWidget{
  List<Item> items;
  List<int>? quantities;
  ItemListView({super.key, required this.items, this.quantities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        TextEditingController quantityController = TextEditingController();
        if (quantities != null && items.length == quantities!.length){
          quantityController.text = quantities![index].toString();
        }
        IconData iconData = quantities == null ? Icons.add : Icons.remove;
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
                      icon: Icon(iconData),
                      onPressed: () {
                        var itemId = items[index].id;
                        var cart = Provider.of<OrderRepository>(context, listen: false);
                        if (iconData == Icons.add) {
                          int qty = int.tryParse(quantityController.text) ?? 1;
                          // Provider.of<OrderRepository>(context, listen: false)
                          cart.addItem(item: items[index], qty: qty);
                        }
                        else{
                          cart.deleteItem(item: items[index]);
                        }
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