import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {

  // 一度値を代入するとその後変更できなくなる。（再代入不可）
  final Function()? onPressed;

  const MyFloatingActionButton({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}
