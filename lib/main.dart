import 'package:flutter/material.dart';
import 'package:heat_map_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      // debugのバナーを非表示
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // 色をまとめて変えれる
      // theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}
