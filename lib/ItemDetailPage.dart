import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/item.dart';

class ItemDetailPage extends StatelessWidget {
  final Item item;
  const ItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Item detail information'),
        ),
        body:
        Center(
          child: Column(
            children: [
              SizedBox(
                width: 400,
                height: 400,
                child: Image.network(item.imageUrl!,
                  fit: BoxFit.fill,),
              ),
              SizedBox(height: 24.0,),
              Text('${item.name}      Price: ${item.price}'),
              SizedBox(height: 8.0,),
              Text('${item.description}')
            ],
          ),
        )
    );
  }
}
