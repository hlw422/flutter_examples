// components/my_button.dart
import 'package:flutter/material.dart';

class recipient extends StatelessWidget {
  final String text;
  final Color color;

  const recipient({ // 参数化构造
    required this.text,
    this.color = Colors.blue,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () => print('$text clicked'),
      child: Text(text),
    );
  }
}