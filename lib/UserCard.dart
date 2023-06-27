import 'package:flutter/cupertino.dart';
import 'model/profile.dart';
class UserCard extends StatelessWidget{
  final Profile user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Username: ${user.username}'),
          const SizedBox(height: 8.0),
          Text("${user.first} ${user.last}")
        ],
      ),
    );
  }

}