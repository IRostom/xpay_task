import 'package:flutter/material.dart';
import 'package:xpay_task/src/src/ui/shops_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: ShopList(),
        ),
      );
  }
}