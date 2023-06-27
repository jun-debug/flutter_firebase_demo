import 'package:flutter/material.dart';

import 'NavBar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.title, this.child});
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: title),
      resizeToAvoidBottomInset: false,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: child
      ),
    );
  }
}
