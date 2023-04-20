import 'package:flutter/material.dart';
import 'package:heat_map_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Firebase を使う時に必要なコード 1
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Firebase を使う時に必要なコード 2
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize hive
  await Hive.initFlutter();
  // open a box
  // 引数にキーを指定することで、キーに対応するBox インスタンスを取得することができます。
  await Hive.openBox("Habit_Database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugのバナーを非表示
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // 色をまとめて変えれる
      // theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}
