import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_demo/model/ItemRepository.dart';
import 'package:flutter_firebase_demo/model/cartOrder.dart';
import 'item.dart';


class OrderRepository extends ChangeNotifier {
  static const DocumentName = "orders";
  var db;
  CartOrder currentOrder = CartOrder();

  int get count => currentOrder == null ? 0 : currentOrder.items.length;


  orderRepository() {
    db = FirebaseFirestore.instance;
  }


  Future<List<CartOrder>> getAllOrders() async {
    var results = await db.collection(DocumentName).get();
    List<CartOrder> orders = [];
    for(var doc in results.docs){
      var order = CartOrder.fromJson(doc.data());
      orders.add(order);
    }
    return orders;
  }



  void addItem({required Item item, required int qty}){
     if (currentOrder != null){
       currentOrder.items[item] = qty;
     }
     notifyListeners();
  }

  // void deleteItem({required String itemId}){
  //   currentOrder.items.remove(itemId);
  // }

  void deleteItem({required Item item}){
    currentOrder.items.remove(item);
    notifyListeners();
  }

  void updateItemQty({required Item item, required int qty}){
    currentOrder.items[item] = qty;
  }

  Future<Item?> getItem({required String itemId}) async {
    var item = await db.collection(ItemRepository.DocumentName).doc(itemId).get();
    if (item.data() != null) {
      return Item.fromJson(item.data());
    }
    else {
      return null;
    }
  }

  Future<Map<Item, int>> getOrderItems() async {
    Map<Item, int> orderItems = {};
    try {
      if (currentOrder != null) {
         for(var element in currentOrder.items.entries){
          Item? item = await getItem(itemId: element.key.id!);
          if (item != null) {
            orderItems[item] = element.value;
          }
        }
      }
    }
    catch (e) {
      print("$e");
    }
    notifyListeners();
    return orderItems;
  }

  Future<CartOrder> getOrder(String? orderId) async {
    if (orderId != null) {
      var existingOrder = await db.collection(DocumentName).doc(orderId).get();
      if (existingOrder.data() != null){
        notifyListeners();
        return CartOrder.fromJson(existingOrder.data());
      }
    }
    var newId = db.collection(DocumentName).doc().id;
    notifyListeners();
    return CartOrder(id: newId);
  }

  void saveOrder() async {
    try {
      db ??= FirebaseFirestore.instance;
      String orderId = currentOrder.id ??
          db.collection(DocumentName)
          .doc()
          .id;
      currentOrder.id = orderId;
      db.collection(DocumentName).doc(currentOrder.id).set(
          currentOrder.toJson());
    }
    catch (e) {
      print("$e");
    }
  }
}