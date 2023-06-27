import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'item.dart';
import 'dart:math';

class ItemRepository extends ChangeNotifier {
  static const DocumentName = "items";
  var db;

  ItemRepository(){
    db = FirebaseFirestore.instance;
  }


  void readData() async {
    var results = await db.collection(DocumentName).get();//.then((event) {
      for (var doc in results.docs) {
        Item item = Item.fromJson(doc.data());
        print(item.name);
      }
  }

  Future<List<Item>> getAllItems() async {
    var results = await db.collection(DocumentName).get();
    List<Item> items = [];
    for(var doc in results.docs){
      var item = Item.fromJson(doc.data());
      items.add(item);
    }
    return items;
  }

  void addItem({String? id, required String name, String? description,
    String? imageUrl, required double price}) async {
    String itemId = id?? db.collection(DocumentName).doc().id;
    var existing = await db.collection(DocumentName).doc(itemId).get();
    if (existing.data() == null) {
      final item = Item(
          id: itemId, name: name, description: description, imageUrl: imageUrl, price: price);
      db.collection(DocumentName).doc(itemId).set(item.toJson());
      notifyListeners();
    }
  }

  //use to generate sample item data
  void writeData() {
    //   final item = <String, dynamic>{
    //   "name": "Treadmill",
    //   "description": "Excellent product",
    //   "imageUrl": "unknown"
    // };
    // db.collection(DocumentName).add(item).then((value) =>
    //     print('DocumentSnapshot added with ID: ${value.id}'));

    String name = generateRandomString(5, 10);
    int i = generateRandomInt(0, 30);
    String imageUrl = "https://i.pravatar.cc/400?img=$i";


    addItem(name: name, description: "Description of $name", imageUrl: imageUrl, price: generateRandomPrice());
    notifyListeners();
  }

  String generateRandomString(int minLength, int maxLength) {
    final random = Random();
    final length = minLength + random.nextInt(maxLength - minLength + 1);
    final codeUnits = List.generate(length, (index) {
      return random.nextInt(26) + 97; // ASCII code for lowercase letters
    });
    return String.fromCharCodes(codeUnits);
  }

  double generateRandomPrice(){
    double randomDouble = Random().nextDouble()*1000;
    double randomDoubleWithTwoDecimals = (randomDouble * 100).round() / 100;
    return randomDoubleWithTwoDecimals;
  }

  int generateRandomInt(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }
}