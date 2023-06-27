import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/UserCard.dart';

import 'model/profile.dart';

class DisplayCards<T> extends StatelessWidget{
  final List<T> users;
  const DisplayCards({super.key, required this.users});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16.0),
            childAspectRatio: 8.0/9.0,
          children: _buildCards(context, users),
        ));
  }

  List<Widget> _buildCards(BuildContext context, List<T> items) {
    if (items == null || items.isEmpty){
      return const <Card>[];
    }
    List<Widget> cards = [];
    if (T is Profile) {
      List<Profile> users = items.cast<Profile>();
      List<Widget> cards = users.map((e) => UserCard(user: e)).toList();
    }

    return cards;
  }
}

