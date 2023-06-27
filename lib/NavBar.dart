import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          semanticLabel: 'menu',
        ),
        onPressed: () {
          print('Menu button');
        },
      ),
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.home,
            semanticLabel: 'home',
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'Home');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.contact_page,
            semanticLabel: 'contact',
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'Register');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.shop,
            semanticLabel: 'Shop equipments',
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'ListItem');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {
            print('Search button');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.tune,
            semanticLabel: 'filter',
          ),
          onPressed: () {
            print('Filter button');
          },
        ),
      ],
    );
  }
}
