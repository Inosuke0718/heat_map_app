import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  // Finalは変数に一度だけ値を代入できる
  // ウィジェットやアニメーションなどを制御するオブジェクト
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  // クラスのコンストラクタ
  const MyAlertBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel,
    });

  // habitの追加
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      actions: [
        MaterialButton(
            // () {}でからの関数を実行する
            onPressed: onSave,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.black),
        MaterialButton(
            onPressed: onCancel,
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.black),
      ],
    );
  }
}
