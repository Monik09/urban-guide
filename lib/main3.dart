import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authentication_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/cart_screens.dart';
import 'screens/edit_product_screen.dart';
import 'screens/manage_orders_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_details_page.dart';
import 'start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhaade Pay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          }
          return AuthenticationScreen(); // MyHomePage(title: 'Flutter Demo Home Page'),
        },
      ),
      routes: {
        '/home': (BuildContext context) => new MyHomePage(),
        '/login': (BuildContext context) => new AuthenticationScreen(),
        ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
        CartScreen.routeName: (ctx) => CartScreen(),
        OrdersScreen.routeName: (ctx) => OrdersScreen(),
        ManageOrdersScreen.routeName: (ctx) => ManageOrdersScreen(),
        EditProductScreen.routeName: (ctx) => EditProductScreen(),
      },
    );
  }
}
