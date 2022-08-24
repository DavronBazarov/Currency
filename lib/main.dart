import 'package:flutter/material.dart';
import 'package:wallet_exchange/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(elevation: 0,)),
      home: HomePage(),);
  }
}
