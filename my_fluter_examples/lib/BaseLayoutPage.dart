// 注册页面：包含邮箱、密码、确认密码输入框以及注册按钮
import 'package:flutter/material.dart';
import 'package:my_fluter_examples/NotesListPage.dart';
import 'package:my_fluter_examples/db/NotesDatabase.dart';
import 'package:my_fluter_examples/model/Note.dart';
import 'dart:async';

import 'package:my_fluter_examples/model/Tag.dart';

class BaseLayoutPage extends StatefulWidget {
  const BaseLayoutPage({super.key});

  @override
  State<BaseLayoutPage> createState() => _BaseLayoutPage();
}

class _BaseLayoutPage extends State<BaseLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("基础页面信息"),
        backgroundColor: Colors.blueAccent,
      ),
            body: Column(
        children: [
          Row(
            children: [
              Container(
                color: Colors.red,
                width: 50,
                height: 50,
              ),
              Container(
                color: Colors.green,
                width: 50,
                height: 50,
              ),
              Container(
                color: Colors.blue,
                width: 50,
                height: 50,
              ),
            ],
          ),
          Container(
            color: Colors.yellow,
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
