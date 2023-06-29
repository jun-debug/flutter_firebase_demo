import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/CheckoutView.dart';
import 'package:flutter_firebase_demo/ItemListView.dart';
import 'package:flutter_firebase_demo/OrderItemListView.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/item.dart';

class OrderDetailPage extends StatefulWidget{
  @override
  _OrderDetailState createState() => _OrderDetailState();

}

class _OrderDetailState extends State<OrderDetailPage> {
  //const OrderDetailPage({super.key});
  bool isCheckingOut = false;

  void toggleVisibility() {
    setState(() {
      isCheckingOut = !isCheckingOut;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<OrderRepository>(context, listen: true);
    List<Item> items = [];
    List<int> quantities = [];
    double totalAmount = 0;
    int totalQty = 0;
    for (var entry in cart.currentOrder.items.entries) {
      items.add(entry.key);
      quantities.add(entry.value);
      totalAmount += entry.key.price * entry.value;
      totalQty += entry.value;
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Order detail'),
          actions: [
            IconButton(
              icon: const Icon(Icons.payment),
              onPressed: toggleVisibility,
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
              },
            ),
          ],
        ),
        body:
        Column(
            children: [
              Visibility(
                child: CheckoutView(),
                visible: isCheckingOut,
              ),
              Container(
                width: double.infinity,
                color: Colors.blueGrey,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Total quantities: $totalQty      Total amount: \$$totalAmount',
                  style: TextStyle(
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child:
                OrderItemListView(items: items, quantities: quantities),
              ),
            ]
        )
    );
  }
}
