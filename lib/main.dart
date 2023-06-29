
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_demo/ListItemPage.dart';
import 'package:flutter_firebase_demo/NavBar.dart';
import 'package:flutter_firebase_demo/OrderDetailPage.dart';
import 'package:flutter_firebase_demo/RegisterPage.dart';
import 'package:flutter_firebase_demo/firebase_options.dart';
import 'package:flutter_firebase_demo/model/ItemRepository.dart';
import 'package:flutter_firebase_demo/model/orderRepository.dart';
import 'package:provider/provider.dart';

import 'model/AuthRepository.dart';
import 'model/ProfileRepository.dart';

void main() async {
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp()
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (context) => ItemRepository()),
    //   ],
    //   child: const MyApp(),
    // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    return
      MultiProvider(
          providers: [
            Provider<AuthRepository>(
              create: (_) => authRepository,
            ),
            StreamProvider(
              create: (context) =>
              context
                  .read<AuthRepository>()
                  .authState, initialData: null,
            ),
            ChangeNotifierProvider(
                create: (context) => ProfileRepository(authRepository)),
            ChangeNotifierProvider(
                create: (context) => ItemRepository()),
            ChangeNotifierProvider(
                create: (context) => OrderRepository()),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routes: {
              'Home': (context) => const MyHomePage(title: "Hello world"),
              'Register': (context) => const RegisterPage(),
              'ListItem': (context) => const ListItemPage(),
              'OrderItemList': (context) => const OrderDetailPage(),
            },
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          )
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: NavBar(title: widget.title),
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  ItemRepository().writeData();
                  Provider.of<ItemRepository>(context,listen: false).writeData();
                  //var orderRepository = Provider.of<OrderRepository>(context, listen: false);
                  //orderRepository.addItem(itemId: "5555522556", qty: 10);
                  //orderRepository.saveOrder();
                  },

                child: const Text('Add')),
            TextButton(
                onPressed: () {
                  // ItemRepository().readData();
                  Provider.of<ItemRepository>(context,listen: false).readData();
                },
                child: const Text('Read')),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
