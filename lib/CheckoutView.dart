import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget{
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context ) {
    var cart = Provider.of<OrderRepository>(context, listen: false);
    TextEditingController controller = TextEditingController();
    return Container(
      width: double.infinity,
      color: Colors.lightBlueAccent,
      padding: EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: '),
            Text('Email: '),
            Text('Address: '),
            SizedBox(height: 4.0,),
            Row(
              children: [
                Text('Credit card: '),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Enter credit card number'
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0,),
            ElevatedButton(
              onPressed: () {
                cart.checkout();
                Navigator.pop(context);
                },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment_rounded),
                  SizedBox(width: 8), // Optional spacing between icon and text
                  Text('Confirm'),
                ],
              ),
            ),
          ]
      ),
    );
  }

}